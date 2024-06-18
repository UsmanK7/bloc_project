import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/cart/bloc/cart_event.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_bloc.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_event.dart';
import 'package:flutter_application_1/model/food_data_model.dart';

class CartFoodCard extends StatelessWidget {
  final FoodModel product;
  final CartBloc cartBloc;
  final int type;

  CartFoodCard(
      {super.key,
      required this.product,
      required this.cartBloc,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image(
                      fit: BoxFit.contain,
                      image: NetworkImage(product.imgPath)),
                ),
                Text(product.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.title),
                    IconButton(
                        onPressed: () {
                          cartBloc.add(RemoveFromCartEvent(
                              product: product, name: product.title));
                        },
                        icon: type == 0
                            ? Icon(Icons.shopping_bag_outlined)
                            : Icon(Icons.shopping_bag)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
