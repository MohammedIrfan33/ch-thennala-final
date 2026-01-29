// To parse this JSON data, do
//
//     final modelMyHistroy = modelMyHistroyFromJson(jsonString);

import 'dart:convert';

ModelMyHistroy modelMyHistroyFromJson(String str) => ModelMyHistroy.fromJson(json.decode(str));


class ModelMyHistroy {
  String name;
  String ward;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String date;
  String status;
  String transactionid;
  String donation;
  String sponorship;

  ModelMyHistroy({
    required this.name,
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.date,
    required this.status,
    required this.transactionid,
    required this.donation,
    required this.sponorship
  });

  factory ModelMyHistroy.fromJson(Map<String, dynamic> json) => ModelMyHistroy(
    name: json["name"],
    ward: json["ward"],
    panchayat: json["panchayat"],
    assembly: json["assembly"],
    district: json["district"],
    amount: json["amount"],
    date: json["date"],
    status: json["status"],
    transactionid: json["Transactionid"],
    donation: json["donation"].toString(),
    sponorship: json["sponsorship"].toString()
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ward": ward,
    "panchayat": panchayat,
    "assembly": assembly,
    "district": district,
    "amount": amount,
    "date": date,
    "status": status,
    "Transactionid": transactionid,
  };
}
