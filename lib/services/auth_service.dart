import 'package:grupchat/main.dart';
import 'package:grupchat/models/notification.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/utils/http/http_client.dart';

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
