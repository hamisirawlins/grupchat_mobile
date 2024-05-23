class PoolListItem {
  String poolId;
  String creatorId;
  String name;
  int targetAmount;
  String type;
  String description;
  String? imageUrl;
  String endDate;
  String createdAt;
  bool archived;
  String? deletedAt;
  Insights insights;
  int numberOfMembers;

  PoolListItem({
    required this.poolId,
    required this.creatorId,
    required this.name,
    required this.targetAmount,
    required this.type,
    required this.description,
    this.imageUrl,
    required this.endDate,
    required this.createdAt,
    required this.archived,
    this.deletedAt,
    required this.insights,
    required this.numberOfMembers,
  });

  factory PoolListItem.fromJson(Map<String, dynamic> json) {
    return PoolListItem(
      poolId: json['pool_id'],
      creatorId: json['creator_id'],
      name: json['name'],
      targetAmount: json['target_amount'],
      type: json['type'],
      description: json['description'],
      imageUrl: json['imageurl'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      archived: json['archived'],
      insights: Insights(
        totalDeposits: json['insights']['totalDeposits'],
        totalWithdrawals: json['insights']['totalWithdrawals'],
      ),
      numberOfMembers: json['numberOfMembers'],
      deletedAt: json['deleted_at'],
    );
  }
}

class Insights {
  int totalDeposits;
  int totalWithdrawals;

  Insights({
    required this.totalDeposits,
    required this.totalWithdrawals,
  });
}
