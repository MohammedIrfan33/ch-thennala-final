import 'dart:convert';

class ChallnegListItems {
  String pro1;
  String pro2;
  String pro3;

  String rate1;
  String rate2;
  String rate3;

  String img1;
  String img2;
  String img3;

  String prodid1;
  String prodid2;
  String prodid3;

  String delivary_date1;
  String delivary_date2;
  String delivary_date3;

  ChallnegListItems(
      {required this.pro1,
      required this.pro2,
      required this.pro3,
      required this.rate1,
      required this.rate2,
      required this.rate3,
      required this.img1,
      required this.img2,
      required this.img3,
      required this.delivary_date1,
      required this.delivary_date2,
      required this.delivary_date3,
      required this.prodid1,
      required this.prodid2,
      required this.prodid3});

  factory ChallnegListItems.fromJson(Map<String, dynamic> json) =>
      ChallnegListItems(
        pro1: json["product_name1"].toString(),
        pro2: json["product_name2"].toString(),
        pro3: json["product_name3"].toString(),
        rate1: json["product_amount1"].toString(),
        rate2: json["product_amount2"].toString(),
        rate3: json["product_amount3"].toString(),
        img1: json["product_image1"].toString(),
        img2: json["product_image2"].toString(),
        img3: json["product_image3"].toString(),
        delivary_date1: json["delivary_date1"].toString(),
        delivary_date2: json["delivary_date2"].toString(),
        delivary_date3: json["delivary_date3"].toString(),
        prodid1: json["prodid1"].toString(),
        prodid2: json["prodid2"].toString(),
        prodid3: json["prodid3"].toString(),
      );
}
