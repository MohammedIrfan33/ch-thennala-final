class Newreportmodel {


  String ward;
  String panchayat;
  String assembly;
  String wardid;
  String panchayatid;
  String amount;
  String quantity;


  Newreportmodel({
    required this.ward,
    required this.panchayat,
    required this.assembly,
    required this.wardid,
    required this.panchayatid,
    required this.amount,
    required this.quantity,});



  factory Newreportmodel.fromJson(Map<String, dynamic> json) => Newreportmodel(
     panchayat: json['panchayat']??"",
    ward: json['ward']??"",
    assembly: json['assembly']??"",
    amount: json['amount']??"",
    quantity: json['quantity']??"",
    panchayatid: json['panchayatid']??"",
    wardid: json['wardid']??"",
  );






}