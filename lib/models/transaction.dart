class Transaction {
  final String transactionId;
  final String poolId;
  final int amount;
  final String type;
  final String description;
  final String status;
  final String createdAt;
  final String initiatedBy;
  final DateTime? deletedAt;
  final String? initiatorName;
  final String profImage;
  final String email;

  Transaction({
    required this.transactionId,
    required this.poolId,
    required this.amount,
    required this.type,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.initiatedBy,
    this.deletedAt,
    this.initiatorName,
    required this.profImage,
    required this.email,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        transactionId: json['transaction_id'],
        poolId: json['pool_id'],
        amount: json['amount'],
        type: json['type'],
        description: json['description'],
        status: json['status'],
        createdAt: json['created_at'],
        initiatedBy: json['initiated_by'],
        deletedAt: json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : null,
        initiatorName: json['users']['name'],
        profImage: json['users']['profile_img'],
        email: json['users']['email']);
  }
}
