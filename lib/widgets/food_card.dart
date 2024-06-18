import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_bloc.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_event.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_state.dart';
import 'package:flutter_application_1/model/food_data_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel product;
  final dynamic bloc;
  final int type;

  FoodCard(
      {super.key,
      required this.product,
      required this.bloc,
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
                  child: ImageWithLoadingIndicator(
                    imageUrl: product.imgPath,
                  ),
                ),
                Text(product.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.title),
                    IconButton(
                        onPressed: () {
                          bloc.add(AddtoFavouriteEvent(product: product));
                        },
                        icon: type == 0
                            ? Icon(Icons.favorite_outline_outlined)
                            : Icon(Icons.favorite_outline_outlined)),
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

class ImageWithLoadingIndicator extends StatelessWidget {
  final String imageUrl;

  const ImageWithLoadingIndicator({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder:
          AssetImage('assets/placeholder.png'), // A local placeholder image
      image: NetworkImage(imageUrl),
      fit: BoxFit.cover,
      placeholderErrorBuilder: (context, error, stackTrace) {
        // This widget is displayed when the placeholder image fails to load
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      imageErrorBuilder: (context, error, stackTrace) {
        // This widget is displayed when the network image fails to load
        return Center(
          child: Icon(Icons.error),
        );
      },
    );
  }
}
