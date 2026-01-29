import 'dart:core';

class Sponsorshipmodel {
  String id;
  String name;
  String rate;
  int _quantity;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Sponsorshipmodel(
      {required this.id,
      required this.name,
      required this.rate,
      required int quantity})
      : _quantity = quantity;
}
