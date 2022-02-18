import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/product.dart';

import 'package:click_to_eat/src/providers/restaurant.dart';

import 'package:click_to_eat/src/screens/restaurant.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:click_to_eat/src/widgets/product.dart';
import 'package:click_to_eat/src/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatelessWidget {
  const RestaurantSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: "Restaurants",
          colors: white,
          size: 20,
          weight: FontWeight.normal,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: grey),
        backgroundColor: black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      backgroundColor: black,
      body:
          // app.isLoading
          //     ? Container(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Loading(),
          //           ],
          //         ),
          //       )
          //:
          restaurantProvider.restaurantSearch.length < 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomText(
                            text: "No restaurants Found",
                            size: 22,
                            colors: grey,
                            weight: FontWeight.w300)
                      ],
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: restaurantProvider.restaurantSearch.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        app.changeLoading();
                        await productProvider.loadProductsByRestaurant(
                          restaurantId:
                              restaurantProvider.restaurantSearch[index].id,
                        );
                        changeScreen(
                            context,
                            RestaurantScreen(
                              restaurantModel:
                                  restaurantProvider.restaurantSearch[index],
                            ));
                        app.changeLoading();
                      },
                      child: RestaurantWidget(
                          restaurant:
                              restaurantProvider.restaurantSearch[index]),
                    );
                  }),
    );
  }
}
