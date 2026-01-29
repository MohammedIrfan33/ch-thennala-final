
class ChangeOrderModel {
  String prodid1;
  String productName1;
  String productImage1;
  String productAmount1;
  int hasordered1Stproduct;
  int firstorderedproductqty;
  String prodid2;
  String productName2;
  String productImage2;
  String productAmount2;
  int hasordered2Ndproduct;
  int secondorderedproductqty;
  String prodid3;
  String productName3;
  String productImage3;
  String productAmount3;
  String delivaryDate3;
  int hasordered3Rdproduct;
  int thirdorderedproductqty;

  ChangeOrderModel({
    required this.prodid1,
    required this.productName1,
    required this.productImage1,
    required this.productAmount1,
    required this.hasordered1Stproduct,
    required this.firstorderedproductqty,
    required this.prodid2,
    required this.productName2,
    required this.productImage2,
    required this.productAmount2,
    required this.hasordered2Ndproduct,
    required this.secondorderedproductqty,
    required this.prodid3,
    required this.productName3,
    required this.productImage3,
    required this.productAmount3,
    required this.delivaryDate3,
    required this.hasordered3Rdproduct,
    required this.thirdorderedproductqty,
  });

  factory ChangeOrderModel.fromJson(Map<String, dynamic> json) => ChangeOrderModel(
    prodid1: json["prodid1"].toString(),
    productName1: json["product_name1"].toString(),
    productImage1: json["product_image1"].toString(),
    productAmount1: json["product_amount1"].toString(),
    hasordered1Stproduct: json["hasordered1stproduct"],
    firstorderedproductqty: json["firstorderedproductqty"],
    prodid2: json["prodid2"].toString(),
    productName2: json["product_name2"].toString(),
    productImage2: json["product_image2"].toString(),
    productAmount2: json["product_amount2"].toString(),
    hasordered2Ndproduct: json["hasordered2ndproduct"],
    secondorderedproductqty: json["secondorderedproductqty"],
    prodid3: json["prodid3"].toString(),
    productName3: json["product_name3"].toString(),
    productImage3: json["product_image3"].toString(),
    productAmount3: json["product_amount3"].toString(),
    delivaryDate3: json["delivary_date3"],
    hasordered3Rdproduct: json["hasordered3rdproduct"],
    thirdorderedproductqty: json["thirdorderedproductqty"],
  );


}
