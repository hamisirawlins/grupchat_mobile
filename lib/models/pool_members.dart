class PoolMember {
  final String userId;
  final String email;
  final String profileImg;
  final String? name;
  final String role;
  final String? phone;

  PoolMember({
    required this.userId,
    required this.email,
    required this.profileImg,
    required this.role,
    this.name,
    this.phone,
  });

  factory PoolMember.fromJson(Map<String, dynamic> json) {
    return PoolMember(
      userId: json['user_id'],
      email: json['email'],
      profileImg: json['profile_img'],
      role: json['role'],
      phone: json['phone'],
      name: json['name'],
    );
  }
}