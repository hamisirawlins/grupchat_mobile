class PoolDetail {
  final String poolId;
  final String creatorId;
  final String name;
  final int targetAmount;
  final String type;
  final String description;
  final String imageUrl;
  final String endDate;
  final String createdAt;
  final bool archived;
  final String? deletedAt;
  final int totalDeposits;
  final int totalWithdrawals;
  final int totalRemaining;
  final List<PoolMember> users;

  PoolDetail({
    required this.poolId,
    required this.creatorId,
    required this.name,
    required this.targetAmount,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.endDate,
    required this.createdAt,
    required this.archived,
    this.deletedAt,
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.totalRemaining,
    required this.users,
  });

  factory PoolDetail.fromJson(Map<String, dynamic> json) {
    List<PoolMember> usersList = [];
    if (json['users'] != null) {
      var usersJson = json['users'] as List;
      usersList =
          usersJson.map((userJson) => PoolMember.fromJson(userJson)).toList();
    }

    return PoolDetail(
      poolId: json['pool_id'] ?? '',
      creatorId: json['creator_id'] ?? '',
      name: json['name'] ?? '',
      targetAmount: json['target_amount'] ?? 0,
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageurl'] ?? '',
      endDate: json['end_date'] ?? '',
      createdAt: json['created_at'] ?? '',
      archived: json['archived'] ?? false,
      deletedAt: json['deleted_at'],
      totalDeposits: json['totalDeposits'] ?? 0,
      totalWithdrawals: json['totalWithdrawals'] ?? 0,
      totalRemaining: json['totalRemaining'] ?? 0,
      users: usersList,
    );
  }
}

class PoolMember {
  final String email;
  final int totalDeposits;
  final int totalWithdrawals;

  PoolMember({
    required this.email,
    required this.totalDeposits,
    required this.totalWithdrawals,
  });

  factory PoolMember.fromJson(Map<String, dynamic> json) {
    return PoolMember(
      email: json['email'] ?? '',
      totalDeposits: json['totalDeposits'] ?? 0,
      totalWithdrawals: json['totalWithdrawals'] ?? 0,
    );
  }
}
