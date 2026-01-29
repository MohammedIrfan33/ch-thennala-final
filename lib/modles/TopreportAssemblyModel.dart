

class TopReportassemblyModel {
  String name;
  String amount;
  String panchayat;

  TopReportassemblyModel({
    required this.name,
    required this.amount,
    required this.panchayat
  });

  factory TopReportassemblyModel.fromJson(Map<String, dynamic> json) => TopReportassemblyModel(
    name: json["name"],
    amount: json["amount"],
    panchayat: json["panchayat"]??""
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
