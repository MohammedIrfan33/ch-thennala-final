

class TopReportassemblyModel {
  String name;
  String amount;
  String panchayat;
  String packets;

  TopReportassemblyModel({
    required this.name,
    required this.amount,
    required this.panchayat,
    required  this.packets
  });

  factory TopReportassemblyModel.fromJson(Map<String, dynamic> json) => TopReportassemblyModel(
    name: json["name"],
    amount: json["amount"],
    panchayat: json["panchayat"]??"",
    packets: json["packet"]??''

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
