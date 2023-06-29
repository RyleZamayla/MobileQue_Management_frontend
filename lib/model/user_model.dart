import 'dart:convert';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? name;
  String? id;
  String? status;
  String? position;
  String? profilePic;
  int? count;

  UserModel({
    this.count,
    this.id,
    this.name,
    this.status,
    this.position,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    count: json["count"],
    id: json["_id"],
    name: json["name"],
    status: json["status"],
    position: json["position"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "_id": id,
    "name": name,
    "status": status,
    "position": position,
    "profilePic": profilePic,
  };
}
