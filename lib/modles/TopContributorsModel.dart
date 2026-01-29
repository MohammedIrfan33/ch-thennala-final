class Topcontributorsmodel {


  String name;
  String amount;


  Topcontributorsmodel({required this.name,required this.amount});



  factory Topcontributorsmodel.fromJson(Map<String, dynamic> json) => Topcontributorsmodel(
    amount: json["amount"],
    name: json["name"],
  );


}