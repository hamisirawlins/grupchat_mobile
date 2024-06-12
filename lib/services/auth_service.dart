import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/notification.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/utils/http/http_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final token = supabase.auth.currentSession!.accessToken;

  Future<UserModel> getUserDetails(String userId) async {
    final response = await HttpUtility.get('admin/users/$userId', token);
    if (response.containsKey('id')) {
      final jsonData = response;
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user details: ${response['error']}');
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      String iosClient = dotenv.env['IOS_CLIENT'] ?? '';
      String webClient = dotenv.env['WEB_CLIENT'] ?? '';
      // Sign in with Google
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClient,
        serverClientId: webClient,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return googleUser;
    } catch (e) {
      return null;
    }
  }

  Future<List<NotificationItem>> getUserNotifications(String userId) async {
    final response =
        await HttpUtility.get('admin/users/$userId/notifications', token);
    if (response.containsKey('data')) {
      final jsonData = response['data'];
      return List<NotificationItem>.from(
          jsonData.map((x) => NotificationItem.fromJson(x)));
    } else {
      throw Exception('Failed to load notifications: ${response['error']}');
    }
  }
}
