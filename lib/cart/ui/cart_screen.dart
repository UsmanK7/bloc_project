import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/cart/bloc/cart_event.dart';
import 'package:flutter_application_1/cart/bloc/cart_state.dart';
import 'package:flutter_application_1/cart/data/cart.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_bloc.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_event.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_state.dart';
import 'package:flutter_application_1/widgets/cart_food_card.dart';
import 'package:flutter_application_1/widgets/food_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  final CartBloc cartBloc = CartBloc();
  void initState() {
    cartBloc.add(CartSuccesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previus, current) => current is! HomeActionState,
      listener: (context, state) => {},
      bloc: cartBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartSuccessState:
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Cart Page",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue,
              ),
              body: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    return CartFoodCard(
                      product: cartProducts[index],
                      cartBloc: cartBloc,
                      type: 1,
                    );
                  }),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
