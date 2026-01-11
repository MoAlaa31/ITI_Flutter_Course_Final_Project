class UserModel {
  String? token;

  UserModel({this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
  }
}