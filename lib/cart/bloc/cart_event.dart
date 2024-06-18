import 'package:flutter_application_1/model/food_data_model.dart';

abstract class CartEvent {}

class CartSuccesEvent extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {
  final FoodModel product;
  final String name;

  RemoveFromCartEvent({required this.product, required this.name});
}
