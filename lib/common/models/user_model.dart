class UserModel {
  final String id;
  final String email;
  final String? phone;

  UserModel({
    required this.id,
    required this.email,
    this.phone,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
