

class TopdaysTopModel {
  String amount;
  String name;


  TopdaysTopModel({
    required this.amount,
    required this.name,
  });

  factory TopdaysTopModel.fromJson(Map<String, dynamic> json) => TopdaysTopModel(
    amount: json["amount"],
    name: json["name"],
  );




}