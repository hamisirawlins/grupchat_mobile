import 'package:grupchat/main.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/utils/http/http_client.dart';

class DataService {
  final token = supabase.auth.currentSession!.accessToken;

  Future<List<Pool>> getPools() async {
    final response = await HttpUtility.get('pools', token);
    if (response.containsKey('data')) {
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((json) => Pool.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pools: ${response['error']}');
    }
  }
}
