import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/cart/ui/cart_screen.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_bloc.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_event.dart';
import 'package:flutter_application_1/home/bloc/bloc/home_state.dart';
import 'package:flutter_application_1/widgets/food_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());

    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previus, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is NavigateToFavouriteState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          }
          if (state is AddtoFavouriteState) {
            final snackBar =
                SnackBar(content: Text("Item is sent to favourite"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case HomeDropdownState:
              final homeDropdownState = state as HomeDropdownState;
              return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Groccerry App",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(NavigateToFavouriteEvent());
                          },
                          icon: Icon(Icons.favorite))
                    ],
                    centerTitle: true,
                    backgroundColor: Colors.blue,
                  ),
                  body: Column(
                    children: [
                      Center(
                        child: Center(
                            child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: homeDropdownState.items
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: homeDropdownState.selectedItem,
                            onChanged: (value) {
                              homeBloc.add(HomeDropdownSelectedEvent(
                                  selectedItem: value!));
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 200,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        )),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: homeDropdownState.products.length,
                              itemBuilder: (context, index) {
                                return FoodCard(
                                    product: homeDropdownState.products[index],
                                    bloc: homeBloc,
                                    type: 0);
                              }))
                    ],
                  ));
            default:
              return SizedBox();
          }
        });
  }
}
