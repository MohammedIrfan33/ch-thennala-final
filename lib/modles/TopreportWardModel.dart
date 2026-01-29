
class TopReportwardModel {
  String name;
  String amount;

  TopReportwardModel({
    required this.name,
    required this.amount,
  });

  factory TopReportwardModel.fromJson(Map<String, dynamic> json) => TopReportwardModel(
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
