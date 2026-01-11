class UserProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
