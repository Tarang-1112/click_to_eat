import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/screens/details.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedRestaurantsScreen extends StatelessWidget {
  const LikedRestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: grey),
        elevation: 0.1,
        backgroundColor: Colors.deepPurple,
        title: CustomText(
          text: "Restaurants I Like",
          colors: white,
          size: 16,
          weight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Column(
          children: restaurantProvider.likedRestaurants
              .map((item) => GestureDetector(
                    onTap: () {
                      // changeScreen(
                      //     context,
                      //     Details(
                      //       product: item,
                      //     ));
                    },
                    child: RestaurantWidget(
                      restaurant: item,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
