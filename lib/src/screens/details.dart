import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/screens/cart.dart';
import 'package:click_to_eat/src/widgets/bottom_navigation_icons.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/small_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: black,
        elevation: 0.0,
        title: Text(widget.product.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Carousel(
            //   images: [
            //     NetworkImage(widget.product.image),
            //     NetworkImage(widget.product.image),
            //     NetworkImage(widget.product.image),
            //   ],
            //   dotBgColor: white,
            //   dotColor: grey,
            //   dotIncreasedColor: purple.shade700,
            //   dotIncreaseSize: 1.5,
            //   autoplay: false,
            // ),
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(
              height: 8,
            ),

            CustomText(
              text: widget.product.name,
              size: 26,
              weight: FontWeight.bold,
              colors: purple.shade700,
            ),
            CustomText(
              text: "\u{20B9}${widget.product.price}",
              size: 20,
              weight: FontWeight.w600,
              colors: purple.shade700,
            ),
            SizedBox(
              height: 10,
            ),

            CustomText(
              text: "Description",
              size: 20,
              weight: FontWeight.w700,
              colors: grey.shade700,
            ),

            Divider(
              color: purple.shade700,
              indent: 100,
              endIndent: 100,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: grey.shade600,
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 36,
                        color: purple.shade700,
                      ),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () async {
                    app.changeLoading();
                    print("All set loading.");
                    bool value = await user.addToCard(
                        product: widget.product, quantity: quantity);
                    print(value);
                    if (value) {
                      print("Item Added to Cart.");
                      _key.currentState!.showSnackBar(
                        SnackBar(
                          content: Text("Added ro Cart!"),
                        ),
                      );
                      user.reloadUserModel();
                      app.changeLoading();
                    } else {
                      print("Item Not Added To Cart.");
                    }
                    print("Loading set to False.");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Add $quantity To Cart",
                        colors: white,
                        size: 22,
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 36,
                        color: purple.shade700,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      }),
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     IconButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       icon: Icon(
            //         Icons.arrow_back,
            //         color: black,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 8.0),
            //       child: Stack(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Stack(
            //               children: <Widget>[
            //                 Image.asset(
            //                   "images/shopping_bag.jpg",
            //                   height: 40,
            //                   width: 40,
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Positioned(
            //             right: 11,
            //             bottom: 4,
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: white,
            //                   borderRadius: BorderRadius.circular(10),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: grey,
            //                       offset: Offset(2, 1),
            //                       blurRadius: 3,
            //                     ),
            //                   ]),
            //               child: Padding(
            //                 padding:
            //                     const EdgeInsets.only(left: 4, right: 4),
            //                 child: CustomText(
            //                     text: "2",
            //                     size: 18,
            //                     colors: purple.shade700,
            //                     weight: FontWeight.bold),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Positioned(
            //   right: 20,
            //   bottom: 55,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: white,
            //       borderRadius: BorderRadius.circular(20),
            //       boxShadow: [
            //         BoxShadow(
            //           color: grey,
            //           offset: Offset(2, 3),
            //           blurRadius: 3,
            //         ),
            //       ],
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(4.0),
            //       child: Icon(
            //         Icons.favorite,
            //         size: 22,
            //         color: red,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      //   CustomText(
      //     text: widget.product.name,
      //     size: 26,
      //     colors: black,
      //     weight: FontWeight.bold,
      //   ),
      //   CustomText(
      //     text: "\u{20B9}${widget.product.price}",
      //     size: 20,
      //     colors: purple.shade700,
      //     weight: FontWeight.w400,
      //   ),
      //   SizedBox(
      //     height: 10,
      //   ),
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.remove,
      //             size: 36,
      //             color: purple.shade700,
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {},
      //         child: Container(
      //           decoration: BoxDecoration(color: purple.shade700),
      //           child: Padding(
      //             padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
      //             child: CustomText(
      //               text: "Add To Bag",
      //               size: 22,
      //               colors: white,
      //               weight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Icons.add,
      //             size: 36,
      //             color: purple.shade700,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ],
    );
  }
}
