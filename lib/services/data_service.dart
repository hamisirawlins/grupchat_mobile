import 'package:grupchat/main.dart';
import 'package:grupchat/models/deposit_request.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/models/pool_create.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/models/pool_members.dart';
import 'package:grupchat/models/transaction.dart';
import 'package:grupchat/models/withdraw_request.dart';
import 'package:grupchat/utils/http/http_client.dart';

class DataService {
  final token = supabase.auth.currentSession!.accessToken;

  Future<List<PoolListItem>> getPools() async {
    final response = await HttpUtility.get('pools', token);
    if (response.containsKey('data')) {
      final jsonData = response['data'] as List;
      return jsonData.map((json) => PoolListItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pools: ${response['error']}');
    }
  }

  Future<Pool> getPool(String poolId) async {
    final response = await HttpUtility.get('pools/$poolId', token);
    if (response.containsKey('pool_id')) {
      final jsonData = response;
      return Pool.fromJson(jsonData);
    } else {
      throw Exception('Failed to load pool details: ${response['error']}');
    }
  }

  Future<List<PoolMember>> getPoolMembers(String poolId) async {
    final queryParams = {'page': 1.toString(), 'pageSize': 40.toString()};
    final response = await HttpUtility.get('pools/$poolId/members', token,
        queryParams: queryParams);
    if (response.containsKey('data')) {
      final jsonData = response['data'] as List;
      return jsonData.map((json) => PoolMember.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load members: ${response['error']}');
    }
  }

  Future<void> removeMember(String poolId, String memberId) async {
    final response =
        await HttpUtility.delete('pools/$poolId/members/$memberId', token);
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to remove member: ${response['error']}');
    }
  }

  Future<void> addMember(String poolId, String? identifier) async {
    final response = await HttpUtility.post(
        'pools/$poolId/members', {'identifier': identifier}, token);

    if (response.containsKey('message')) {
      return response['message'];
    } else {
      throw Exception('Failed to update: ${response['error']}');
    }
  }

  Future<void> withdrawFromPool(String poolId, WithdrawRequest request) async {
    final response = await HttpUtility.post(
        'pools/$poolId/withdraw', request.toJson(), token);
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to withdraw from pool: ${response['error']}');
    }
  }

  Future<void> depositToPool(String poolId, DepositRequest request) async {
    final response = await HttpUtility.post(
        'pools/$poolId/deposit', request.toJson(), token);
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to deposit to pool: ${response['error']}');
    }
  }

  Future<dynamic> createPool(PoolCreate pool) async {
    final response = await HttpUtility.post('pools', pool.toJson(), token);
    if (response.containsKey('pool')) {
      return response['pool'];
    } else {
      throw Exception('Failed to create pool: ${response['error']}');
    }
  }

  Future<void> updatePool(String poolId, Pool pool) async {
    final response =
        await HttpUtility.put('pools/$poolId', pool.toJson(), token);
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to update pool: ${response['error']}');
    }
  }

  Future<void> deletePool(String poolId) async {
    final response = await HttpUtility.delete('pools/$poolId', token);
    
    if (response.containsKey('message')) {
      return;
    } else {
      throw Exception('Failed to delete pool: ${response['error']}');
    }
  }

  Future<List<Transaction>> getTransactions(
      {String? poolId, String? search, int? page, int? pageSize}) async {
    final queryParams = {
      if (search != null) 'search': search,
      if (poolId != null) 'poolId': poolId,
      if (page != null) 'page': page.toString(),
      if (pageSize != null) 'pageSize': pageSize.toString()
    };
    final response = await HttpUtility.get('pools/transactions', token,
        queryParams: queryParams);

    if (response.containsKey('data')) {
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions: ${response['error']}');
    }
  }
}
