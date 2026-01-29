import 'dart:core';
import 'dart:ui';

class Challegelistmodel {
  String name;
  String rate;
  int _quantity;
  String img;
  String productid;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Challegelistmodel(
      {required this.name,
      required this.productid,
      required this.rate,
      required int quantity,
      required this.img})
      : _quantity = quantity;
}
