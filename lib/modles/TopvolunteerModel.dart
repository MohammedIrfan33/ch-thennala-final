import 'dart:convert';



class TopvolunteersModel {
  String name;
  String amount;
  String ward;
  String volunteernumber;

  TopvolunteersModel({
    required this.name,
    required this.amount,
    required this.ward,
    required this.volunteernumber,
  });

  factory TopvolunteersModel.fromJson(Map<String, dynamic> json) => TopvolunteersModel(
    name: json["name"],
    amount: json["amount"],
    ward: json["ward"],
    volunteernumber: json["volunteernumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
    "ward": ward,
    "volunteernumber": volunteernumber,
  };
}
