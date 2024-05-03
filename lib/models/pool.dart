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
  final String? deletedAt; // Make this field nullable

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
      deletedAt: json['deleted_at'], 
    );
  }
}
