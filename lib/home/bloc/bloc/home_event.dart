import 'package:flutter_application_1/model/food_data_model.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeInitialEvent extends HomeEvent {}

class HomeSuccesEvent extends HomeEvent {}

class HomeDropdownSelectedEvent extends HomeEvent {
  String selectedItem;
  HomeDropdownSelectedEvent({required this.selectedItem});
}

class AddtoFavouriteEvent extends HomeEvent {
  final FoodModel product;

  AddtoFavouriteEvent({required this.product});
}


class NavigateToFavouriteEvent extends HomeEvent{

}
