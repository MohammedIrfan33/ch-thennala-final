import 'dart:convert';


class PanchayatModel {
  String id;
  String name;
  String assemblyid;

  PanchayatModel({
    required this.id,
    required this.name,
    required this.assemblyid
  });

  factory PanchayatModel.fromJson(Map<String, dynamic> json) => PanchayatModel(
    id: json["id"],
    name: json["name"],
    assemblyid: json["name"]??""
  );


}
