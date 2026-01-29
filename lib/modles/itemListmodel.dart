import 'dart:convert';

class Itemlistmodel {
  String id1;
  String id2;
  String id3;
  String id4;
  String id5;

  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String rate1;
  String rate2;
  String rate3;
  String rate4;
  String rate5;

  Itemlistmodel({
    required this.id1,
    required this.id2,
    required this.id3,
    required this.id4,
    required this.id5,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.rate1,
    required this.rate2,
    required this.rate3,
    required this.rate4,
    required this.rate5,
  });

  factory Itemlistmodel.fromJson(Map<String, dynamic> json) => Itemlistmodel(
    id1: json["id1"].toString() ,
    id2:json["id2"].toString(),
    id3: json["id3"].toString(),
    id4: json["id4"].toString(),
    id5: json["id5"].toString(),
    the1: json["1"].toString(),
    the2: json["2"].toString(),
    the3: json["3"].toString(),
    the4: json["4"].toString(),
    the5: json["5"].toString(),
    rate1: json["rate1"].toString(),
    rate2: json["rate2"].toString(),
    rate3: json["rate3"].toString(),
    rate4: json["rate4"].toString(),
    rate5: json["rate5"].toString(),
  );


}
