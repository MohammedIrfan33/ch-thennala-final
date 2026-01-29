


class TopReportpanchayatModel {
  String name;
  String amount;

  TopReportpanchayatModel({
    required this.name,
    required this.amount,
  });

  factory TopReportpanchayatModel.fromJson(Map<String, dynamic> json) => TopReportpanchayatModel(
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
