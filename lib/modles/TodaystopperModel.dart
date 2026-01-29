
class TodayTopperModel {
  String name;
  String amount;

  TodayTopperModel({
    required this.name,
    required this.amount,
  });

  factory TodayTopperModel.fromJson(Map<String, dynamic> json) => TodayTopperModel(
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
