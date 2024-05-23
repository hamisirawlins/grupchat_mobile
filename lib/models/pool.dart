class Pool {
  String poolId;
  String creatorId;
  String name;
  int targetAmount;
  String type;
  String description;
  String? imageUrl;
  String endDate;
  DateTime createdAt;
  bool? archived;
  DateTime? deletedAt;
  Insights insights;
  List<PoolUser> users;

  Pool({
    required this.poolId,
    required this.creatorId,
    required this.name,
    required this.targetAmount,
    required this.type,
    required this.description,
    this.imageUrl,
    required this.endDate,
    required this.createdAt,
    this.archived,
    required this.insights,
    required this.users,
    this.deletedAt,
  });

  factory Pool.fromJson(Map<String, dynamic> json) {
    return Pool(
      poolId: json['pool_id'],
      creatorId: json['creator_id'],
      name: json['name'],
      targetAmount: json['target_amount'],
      type: json['type'],
      description: json['description'],
      imageUrl: json['imageurl'],
      endDate: (json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
      archived: json['archived'],
      insights: Insights.fromJson(json['insights']),
      users:
          List<PoolUser>.from(json['users'].map((x) => PoolUser.fromJson(x))),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  //to json
  Map<String, dynamic> toJson() => {
        'name': name,
        'target_amount': targetAmount,
        'type': type,
        'description': description,
        'imageurl': imageUrl,
        'end_date': endDate,
        'archived': archived,
      };
}

class Insights {
  int totalDeposits;
  int totalWithdrawals;

  Insights({
    required this.totalDeposits,
    required this.totalWithdrawals,
  });

  factory Insights.fromJson(Map<String, dynamic> json) {
    return Insights(
      totalDeposits: json['totalDeposits'],
      totalWithdrawals: json['totalWithdrawals'],
    );
  }
}

class PoolUser {
  String email;
  String profileImg;
  int totalDeposits;
  int totalWithdrawals;

  PoolUser({
    required this.email,
    required this.profileImg,
    required this.totalDeposits,
    required this.totalWithdrawals,
  });

  factory PoolUser.fromJson(Map<String, dynamic> json) {
    return PoolUser(
      email: json['email'],
      profileImg: json['profile_img'],
      totalDeposits: json['totalDeposits'],
      totalWithdrawals: json['totalWithdrawals'],
    );
  }
}
