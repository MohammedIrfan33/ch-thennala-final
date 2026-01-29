
class Appverssion {
  String appversionnumber;
  String hide;
  int expired;
  Appverssion({
    required this.appversionnumber,
    required this.hide,
    required this.expired
  });

  factory Appverssion.fromJson(Map<String, dynamic> json) => Appverssion(
    appversionnumber: json["Appversionnumber"],
    hide: json["hideforappstore"],
    expired: json["expired"]

  );


}
