import 'dart:convert';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String id;
  String name;
  String email;
  String? status;
  String position;
  int queueLimit;
  String? profilePic;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.position,
    required this.queueLimit,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    position: json["position"],
    queueLimit: json["queueLimit"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "status": status,
    "position": position,
    "queueLimit": queueLimit,
    "profilePic": profilePic,
  };
}
