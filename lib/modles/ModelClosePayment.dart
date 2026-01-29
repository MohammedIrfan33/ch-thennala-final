

import 'dart:convert';

ModelClosePayment modelClosePaymentFromJson(String str) => ModelClosePayment.fromJson(json.decode(str));


class ModelClosePayment {
  String status;
  int data;
  String orderId;
  String hash;
  String name;
  String mobile;

  ModelClosePayment({
    required this.status,
    required this.data,
    required this.orderId,
    required this.hash,
    required this.name,
    required this.mobile,
  });

  factory ModelClosePayment.fromJson(Map<String, dynamic> json) => ModelClosePayment(
    status: json["Status"]??"",
    data: json["data"]??"",
    orderId: json["order_id"]??"",
    hash: json["hash"]??"",
    name: json["name"]??"",
    mobile: json["mobile"]??"",
  );


}
