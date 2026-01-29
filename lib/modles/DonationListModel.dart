

class Donationlistmodel {

   String id;
   String name;
   String amount;


   Donationlistmodel({
     required this.id,
     required this.name,
     required this.amount
   });

   factory Donationlistmodel.fromJson(Map<String, dynamic> json) => Donationlistmodel(
     id: json["id"],
     name: json["name"],
     amount: json["amount"]
   );










}