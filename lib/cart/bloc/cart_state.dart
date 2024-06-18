import 'package:flutter_application_1/model/food_data_model.dart';

abstract class CartState {}

abstract class CartActionState {}

class InitialCartState extends CartState {}

class CartSuccessState extends CartState {
  List<FoodModel> food_items;
  CartSuccessState({required this.food_items});
}

class ProductRemoveFromCartState extends CartActionState {
  final String name;

  ProductRemoveFromCartState({required this.name});
}
class RemoveFromCartState extends CartActionState{
  
}
