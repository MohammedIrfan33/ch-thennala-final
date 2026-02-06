


class TopReportpanchayatModel {
  String name;
  String amount;
  String packets;

  TopReportpanchayatModel({
    required this.name,
    required this.amount,
    required this.packets
  });

  factory TopReportpanchayatModel.fromJson(Map<String, dynamic> json) => TopReportpanchayatModel(
    name: json["name"]??'',
    amount: json["amount"]??'',
     packets:  json['packet']??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
