

class ContributehistoryModel {
  String customerid;
  String name;
  String ward;
  String panchayat;
  String assembly;
  String district;
  String amount;
  String month;
  String day;
  String time;
  String id;
  int fullypaid;
  int canchangeward;
  String panchayatid;
  String receiptname;


  ContributehistoryModel({
    required this.customerid,
    required this.name,
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.district,
    required this.amount,
    required this.month,
    required this.day,
    required this.time,
    required this.id,
    required this.fullypaid,
    required this.canchangeward,
    required this.panchayatid,
    required this.receiptname
  });

  factory ContributehistoryModel.fromJson(Map<String, dynamic> json) => ContributehistoryModel(
    customerid: json["customerid"],
    name: json["name"],
    ward: json["ward"],
    panchayat: json["panchayat"],
    assembly: json["assembly"],
    district: json["district"],
    amount: json["amount"],
    month: json["month"],
    day: json["day"],
    time: json["time"],
    id: json["id"],
    fullypaid: json["fullypaid"],
    canchangeward: json["canchangeward"],
      panchayatid:json["panchayatid"],
    receiptname: json["receiptname"]
  );


}
