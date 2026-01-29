import 'dart:core';

class ChangeOrderList {
  String name;
  String rate;
  int _quantity;
  String img;
  String productid;
  int hasOrdered;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  ChangeOrderList(
      {required this.name,
        required this.productid,
        required this.rate,
        required int quantity,
        required this.hasOrdered,
        required this.img})
      : _quantity = quantity;
}