// To parse this JSON data, do
//
//     final adminResponse = adminResponseFromJson(jsonString);

import 'dart:convert';

AdminResponse adminResponseFromJson(String str) =>
    AdminResponse.fromJson(json.decode(str));

String adminResponseToJson(AdminResponse data) => json.encode(data.toJson());

class AdminResponse {
  String status;
  List<Admin> admins;

  AdminResponse({required this.status, required this.admins});

  factory AdminResponse.fromJson(Map<String, dynamic> json) => AdminResponse(
    status: json["status"],
    admins: List<Admin>.from(json["data"].map((x) => Admin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(admins.map((x) => x.toJson())),
  };
}

class Admin {
  int id;
  String correo;
  String pass;
  String apiKey;

  Admin({
    required this.id,
    required this.correo,
    required this.pass,
    required this.apiKey,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    correo: json["correo"],
    pass: json["pass"],
    apiKey: json["api_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "correo": correo,
    "pass": pass,
    "api_key": apiKey,
  };
}
