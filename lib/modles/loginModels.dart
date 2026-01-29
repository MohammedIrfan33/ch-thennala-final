// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';


class Usermodel {
  String id;
  String name;
  String mobile;
  String clubId;

  Usermodel({
    required this.id,
    required this.name,
    required this.mobile,
    required this.clubId
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    clubId: json["clubid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile":mobile
  };
}
