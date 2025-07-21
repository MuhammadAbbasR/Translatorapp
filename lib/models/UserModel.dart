class UserModel {
  String username;
  String email;
  String password;
  bool sessionactive;

  UserModel(
      {this.username = "",
        required this.email,
        required this.password,
        this.sessionactive = false});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': username,
      'session': sessionactive
    };
  }


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        password: json['password'],
        username: json['name'],
        sessionactive: json['session']);
  }
}
