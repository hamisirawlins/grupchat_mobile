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

  Future<Pool?> getPool(String poolId) async {
    final response = await HttpUtility.get('pools/$poolId', token);
    if (response.containsKey('pool_id')) {
      final jsonData = response;
      return Pool.fromJson(jsonData);
    } else {
      throw Exception('Failed to load pool details: ${response['error']}');
    }
  }

  Future<void> withdrawFromPool(String poolId, WithdrawRequest request) async {
    final response = await HttpUtility.post(
        'pools/$poolId/withdraw', request.toJson(), token);
    print(response);
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to withdraw from pool: ${response['error']}');
    }
  }
}
