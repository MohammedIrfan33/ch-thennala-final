import 'dart:convert';

import 'package:get/get.dart';


class AssemblyModel {
  String id;
  String name;

  AssemblyModel({
    required this.id,
    required this.name,
  });

  factory AssemblyModel.fromJson(Map<String, dynamic> json) => AssemblyModel(
    id: json["id"],
    name: json["name"],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AssemblyModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name.removeAllWhitespace;
}
