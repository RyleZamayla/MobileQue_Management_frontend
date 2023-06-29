// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String accessToken;
  User user;

  LoginModel({
    required this.accessToken,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["accessToken"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String name;
  String email;
  String position;
  int queueLimit;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.queueLimit,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    position: json["position"],
    queueLimit: json["queueLimit"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "position": position,
    "queueLimit": queueLimit,
  };
}
