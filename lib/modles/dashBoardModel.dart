


class DashboardModel {
  double count;
  String description;
  String unit;
  String Received;

  DashboardModel({
    required this.count,
    required this.description,
    required this.unit,
    required this.Received
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    count:double.parse( json["Count"]),
    description: json["Description"],
    unit: json["unit"],
    Received: json["Received"]
  );


}
