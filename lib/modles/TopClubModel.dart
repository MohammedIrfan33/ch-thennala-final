import 'dart:convert';
class TopClubModel {
  String name;
  String amount;

  TopClubModel({
    required this.name,
    required this.amount,
  });

  factory TopClubModel.fromJson(Map<String, dynamic> json) => TopClubModel(
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
