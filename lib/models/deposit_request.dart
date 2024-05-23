class DepositRequest {
  final String poolId;
  final double amount;
  final String phone;

  DepositRequest(
      {required this.poolId, required this.amount, required this.phone});

  Map<String, dynamic> toJson() {
    return {'pool_id': poolId, 'amount': amount, 'phone': phone};
  }
}
