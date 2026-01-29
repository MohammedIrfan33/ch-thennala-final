
class CallengeSponsorModel {
  String id;
  String name;
  String ward;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String payable;
  String show_receipt_status;
  String image;
  String count;
  String date_time;




  CallengeSponsorModel({
    required this.id,
    required this.name,
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.payable,
    required this.date_time,
    required this.show_receipt_status,
    this.count="0 Kg",
    this.image=""

  });

  factory CallengeSponsorModel.fromJson(Map<String, dynamic> json) => CallengeSponsorModel(
    name: json["name"],
    ward: json["ward"],
    panchayat: json["panchayat"],
    assembly: json["assembly"],
    district: json["district"],
    amount: json["amount"],
    payable: json["payable"],
    date_time:json["date"]??"",
    id: json["id"],
    show_receipt_status: json["show_receipt_status"].toString()??"",
    count:  json["count"]??"0 Kg",
    image: json["image"]??"",
  );

}
