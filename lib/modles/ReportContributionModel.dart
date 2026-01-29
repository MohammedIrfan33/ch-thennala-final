
class ReprotCondributionModel {
  String name;
  String ward;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String date;

  ReprotCondributionModel({
    required this.name,
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.date
  });

  factory ReprotCondributionModel.fromJson(Map<String, dynamic> json) => ReprotCondributionModel(
    name: json["name"],
    ward: json["ward"],
    panchayat: json["panchayat"],
    assembly: json["assembly"],
    district: json["district"],
    amount: json["amount"],
    date:  json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ward": ward,
    "panchayat": panchayat,
    "assembly": assembly,
    "district": district,
    "amount": amount,
  };
}
