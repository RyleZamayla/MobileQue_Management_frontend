import 'dart:convert';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? name;
  String? email;
  String? id;
  String? status;
  String? position;
  String? profilePic;
  int? count;
  int? queueLimit;

  UserModel({
    this.count,
    this.queueLimit,
    this.id,
    this.email,
    this.name,
    this.status,
    this.position,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    queueLimit: json["queueLimit"],
    count: json["count"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    position: json["position"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "queueLimit": queueLimit,
    "count": count,
    "_id": id,
    "name": name,
    "email": email,
    "status": status,
    "position": position,
    "profilePic": profilePic,
  };
}
