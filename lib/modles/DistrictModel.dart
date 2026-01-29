import 'dart:convert';

import 'package:get/get.dart';


class DistrictModel {
  String id;
  String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    id: json["id"],
    name: json["name"],
  );


}
