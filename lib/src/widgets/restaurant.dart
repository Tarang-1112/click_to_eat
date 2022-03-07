import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/restaurant.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:click_to_eat/src/widgets/small_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantWidget extends StatefulWidget {
  final RestaurantModel restaurant;
  const RestaurantWidget({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Padding(
      padding:
          const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0, bottom: 4.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 120,
                        child: Loading(),
                      ),
                    ),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.restaurant.image),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.restaurant.liked = !widget.restaurant.liked;
                      });
                      restaurantProvider.likeOrDislikeProduct(
                        userId: user.userModel!.id,
                        restaurant: widget.restaurant,
                        liked: widget.restaurant.liked,
                      );
                      restaurantProvider.loadLikedRestaurants(
                          id: user.userModel!.id);
                    },
                    child: !widget.restaurant.liked
                        ? Icon(
                            Icons.favorite_sharp,
                            size: 20,
                            color: red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: red,
                          ),
                  ),
                ),
                //SmallButton(Icons.favorite),
                // SizedBox(
                //   width: 220,
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 5.0),
                  child: Container(
                    width: 85,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow.shade900,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(widget.restaurant.rating.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ]),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "${widget.restaurant.name} \n",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Average Meal Price : ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: "\u{20B9}${widget.restaurant.averagePrice}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                        style: TextStyle(color: Colors.lightGreen.shade100),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 220,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: RichText(
                  //       text: TextSpan(children: [
                  //     TextSpan(
                  //       text: "\u{20B9}180",
                  //       style: TextStyle(
                  //           fontSize: 22,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.lightBlue.shade100),
                  //     ),
                  //   ])),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
