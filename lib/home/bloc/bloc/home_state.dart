import 'package:flutter_application_1/model/food_data_model.dart';

abstract class HomeState {
  const HomeState();
}

abstract class HomeActionState extends HomeState {
  const HomeActionState();
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class HomeDropdownState extends HomeState {
  final selectedItem;
  final List<String> items;
  final List<FoodModel> products;

  HomeDropdownState(
      {required this.selectedItem,
      required this.items,
      required this.products});
}

class AddtoFavouriteState extends HomeActionState {}

class NavigateToFavouriteState extends HomeActionState {}
