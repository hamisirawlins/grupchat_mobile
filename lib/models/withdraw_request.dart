class WithdrawRequest {
  final String poolId;
  final double amount;
  final String phone;

  WithdrawRequest(
      {required this.poolId, required this.amount, required this.phone});

  Map<String, dynamic> toJson() {
    return {'pool_id': poolId, 'amount': amount, 'phone': phone};
  }
}
