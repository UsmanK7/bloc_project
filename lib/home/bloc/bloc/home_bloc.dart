import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/cart/data/cart.dart';
import 'package:flutter_application_1/data/food_items.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_event.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_state.dart';
import 'package:flutter_application_1/model/food_data_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeDropdownSelectedEvent>(homeDropdownSelectedEvent);
    on<AddtoFavouriteEvent>(addtoFavouriteEvent);
    on<NavigateToFavouriteEvent>(navigateToFavouriteEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    List<String> products =
        FoodItems.foodItems.map((e) => e["title"] as String).toList();

    emit(HomeLoadedState());
    emit(HomeDropdownState(
        items: products,
        selectedItem: null,
        products: FoodItems.foodItems
            .map((e) => FoodModel(
                id: e["id"],
                title: e["title"],
                description: e["description"],
                price: e["price"],
                imgPath: e["imagePath"]))
            .toList()));
  }

  FutureOr<void> homeDropdownSelectedEvent(
      HomeDropdownSelectedEvent event, Emitter<HomeState> emit) {
    List<String> items =
        FoodItems.foodItems.map((e) => e["title"] as String).toList();
    emit(HomeDropdownState(
        selectedItem: event.selectedItem,
        items: items,
        products: FoodItems.foodItems
            .where((element) => element["title"] == event.selectedItem)
            .map((e) => FoodModel(
                id: e["id"],
                title: e["title"],
                description: e["description"],
                price: e["price"],
                imgPath: e["imagePath"]))
            .toList()));
  }

  FutureOr<void> addtoFavouriteEvent(
      AddtoFavouriteEvent event, Emitter<HomeState> emit) {
    cartProducts.add(event.product);
    emit(AddtoFavouriteState());
  }

  FutureOr<void> navigateToFavouriteEvent(
      NavigateToFavouriteEvent event, Emitter<HomeState> emit) {
    emit(NavigateToFavouriteState());
  }
}
