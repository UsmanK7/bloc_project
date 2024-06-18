import 'dart:async';

import 'package:flutter_application_1/cart/bloc/cart_event.dart';
import 'package:flutter_application_1/cart/bloc/cart_state.dart';
import 'package:flutter_application_1/cart/data/cart.dart';
import 'package:flutter_application_1/data/food_items.dart';
import 'package:flutter_application_1/model/food_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<CartSuccesEvent>(cartSuccesEvent);

    on<RemoveFromCartEvent>(removeFromCartEvent);
  }

  FutureOr<void> removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    cartProducts.remove(event.product);
    
    emit(CartSuccessState(food_items: cartProducts));
  }

  FutureOr<void> cartSuccesEvent(
      CartSuccesEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(food_items: cartProducts));
  }
}
