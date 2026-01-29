// To parse this JSON data, do
//
//     final challengehistoryModel = challengehistoryModelFromJson(jsonString);

import 'dart:convert';

ChallengehistoryModel challengehistoryModelFromJson(String str) => ChallengehistoryModel.fromJson(json.decode(str));

String challengehistoryModelToJson(ChallengehistoryModel data) => json.encode(data.toJson());

class ChallengehistoryModel {
  String name;
  String ward;
  String club;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String month;
  String day;
  String time;
  String id;
  int fullypaid;
  String panchayatid;
  String customerid;
  int caneditorder;
  int canchangeward;
  String receiptname;


  ChallengehistoryModel({
    required this.name,
    required this.ward,
    required this.club,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.month,
    required this.day,
    required this.time,
    required this.id,
    required this.fullypaid,
    required this.panchayatid,
    required this.customerid,
    required this.caneditorder,
    required this.canchangeward,
    required this.receiptname
  });

  factory ChallengehistoryModel.fromJson(Map<String, dynamic> json) => ChallengehistoryModel(
    name: json["name"].toString(),
    ward: json["ward"].toString(),
    club:json["club"]??"NA",
    panchayat: json["panchayat"].toString(),
    assembly: json["assembly"].toString(),
    district: json["district"].toString(),
    amount: json["amount"].toString(),
    month: json["month"].toString(),
    day: json["day"].toString(),
    time: json["time"].toString(),
    id: json["id"].toString(),
    fullypaid: json["fullypaid"],
    panchayatid: json["panchayatid"].toString(),
    customerid: json["customerid"].toString(),
    caneditorder: json["caneditorder"],
    canchangeward: json["canchangeward"],
    receiptname:  json["receiptname"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ward": ward,
    "panchayat": panchayat,
    "assembly": assembly,
    "district": district,
    "amount": amount,
    "month": month,
    "day": day,
    "time": time,
    "id": id,
    "fullypaid": fullypaid,
    "panchayatid": panchayatid,
    "customerid": customerid,
    "caneditorder": caneditorder,
    "canchangeward": canchangeward,
  };
}
