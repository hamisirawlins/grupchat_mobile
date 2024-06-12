class UserModel {
  String id;
  String email;
  String? phone;
  String? name;
  String profileImg;
  String notifications;

  UserModel(
      {required this.id,
      required this.email,
      this.phone,
      this.name,
      required this.profileImg,
      required this.notifications});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      profileImg: json['profile_img'],
      notifications: json['profile_img'],
    );
  }
}
