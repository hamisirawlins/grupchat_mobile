class Pool {
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
  final int numberOfMembers;

  Pool({
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
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.numberOfMembers,
    this.deletedAt,
  });

  factory Pool.fromJson(Map<String, dynamic> json) {
    return Pool(
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
      totalDeposits: json['insights']['totalDeposits'] ?? 0,
      totalWithdrawals: json['insights']['totalWithdrawals'] ?? 0,
      numberOfMembers: json['numberOfMembers'] ?? 0,
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pool_id': poolId,
      'creator_id': creatorId,
      'name': name,
      'target_amount': targetAmount,
      'type': type,
      'description': description,
      'imageurl': imageUrl,
      'end_date': endDate,
      'created_at': createdAt,
      'archived': archived,
      'deleted_at': deletedAt,
      'insights': {
        'totalDeposits': totalDeposits,
        'totalWithdrawals': totalWithdrawals,
      },
      'numberOfMembers': numberOfMembers,
    };
  }
}

class WithdrawRequest {
  final int amount;
  final int phone;

  WithdrawRequest({required this.amount, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'phone': phone,
    };
  }
}

class DepositRequest {
  final int amount;
  final int phone;

  DepositRequest({required this.amount, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'phone': phone,
    };
  }
}
