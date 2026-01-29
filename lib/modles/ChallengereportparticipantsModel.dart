
import 'dart:ui';

class CallengereportPartisipationModel {
  String id;
  String name;
  String ward;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String payable;
  String date;
  int caneditorder;
  String show_receipt_status;


  CallengereportPartisipationModel({
    required this.id,
    required this.name,
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.payable,
    required this.date,
    required this.caneditorder,
    required this.show_receipt_status
  });

  factory CallengereportPartisipationModel.fromJson(Map<String, dynamic> json) => CallengereportPartisipationModel(
    id: json["id"]??"",
    name: json["name"]??"",
    ward: json["ward"]??"",
    panchayat: json["panchayat"]??"",
    assembly: json["assembly"]??"",
    district: json["district"]??"",
    amount: json["amount"]??"",
    payable: json["payable"]??"",
    date: json["date"]??"",
    caneditorder: json["caneditorder"]??"",
    show_receipt_status: json["show_receipt_status"].toString()

  );

}
