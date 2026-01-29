import 'dart:convert';

import 'package:get/get.dart';


class ClubModel {
  String id;
  String name;

  ClubModel({
    required this.id,
    required this.name,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
    id: json["id"],
    name: json["name"],
  );


}
