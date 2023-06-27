import 'dart:convert';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? name;
  String? userId;
  String? status;
  String? position;
  String? profilePic;
  int? count;

  UserModel({
    this.count,
    this.userId,
    this.name,
    this.status,
    this.position,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    count: json["count"],
    userId: json["userId"],
    name: json["name"],
    status: json["status"],
    position: json["position"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "userId": userId,
    "name": name,
    "status": status,
    "position": position,
    "profilePic": profilePic,
  };
}
