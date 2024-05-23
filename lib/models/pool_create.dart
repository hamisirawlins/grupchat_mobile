class PoolCreate {
  String name;
  double targetAmount;
  String description;
  DateTime endDate;
  String type;

  PoolCreate(
      {required this.name,
      required this.targetAmount,
      required this.description,
      required this.endDate,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'target_amount': targetAmount,
      'description': description,
      'type': type,
      'end_date': endDate.toIso8601String(),
    };
  }
}
