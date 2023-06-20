// To parse this JSON data, do
//
//     final queuesModel = queuesModelFromJson(jsonString);

import 'dart:convert';

List<QueuesModel> queuesModelFromJson(String str) => List<QueuesModel>.from(json.decode(str).map((x) => QueuesModel.fromJson(x)));

String queuesModelToJson(List<QueuesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QueuesModel {
  String id;
  String userId;
  String name;
  String idNumber;
  String email;
  String purpose;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  QueuesModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.idNumber,
    required this.email,
    required this.purpose,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory QueuesModel.fromJson(Map<String, dynamic> json) => QueuesModel(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    idNumber: json["idNumber"],
    email: json["email"],
    purpose: json["purpose"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "idNumber": idNumber,
    "email": email,
    "purpose": purpose,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
