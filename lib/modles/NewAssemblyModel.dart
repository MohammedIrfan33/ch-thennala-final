import 'dart:convert';

import 'package:get/get.dart';


class NewAssemblyModel {
  String id;
  String name;
  String districtid;

  NewAssemblyModel({
    required this.id,
    required this.name,
    required this.districtid
  });

  factory NewAssemblyModel.fromJson(Map<String, dynamic> json) => NewAssemblyModel(
    id: json["id"],
    name: json["name"],
    districtid:json["districtid"]??""
  );


}
