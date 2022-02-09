import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/widgets/bottom_navigation_icons.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/small_floating_button.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Product product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Carousel(
                    images: [
                      AssetImage('images/${widget.product.image}'),
                      AssetImage('images/${widget.product.image}'),
                      AssetImage('images/${widget.product.image}'),
                    ],
                    dotBgColor: white,
                    dotColor: grey,
                    dotIncreasedColor: purple.shade700,
                    dotIncreaseSize: 1.5,
                    autoplay: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    "images/shopping_bag.jpg",
                                    height: 40,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 11,
                              bottom: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: grey,
                                        offset: Offset(2, 1),
                                        blurRadius: 3,
                                      ),
                                    ]),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: CustomText(
                                      text: "2",
                                      size: 18,
                                      colors: purple.shade700,
                                      weight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    bottom: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: grey,
                            offset: Offset(2, 3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.favorite,
                          size: 22,
                          color: red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomText(
              text: widget.product.name,
              size: 26,
              colors: black,
              weight: FontWeight.bold,
            ),
            CustomText(
              text: "\u{20B9}${widget.product.price}",
              size: 20,
              colors: purple.shade700,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      size: 36,
                      color: purple.shade700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(color: purple.shade700),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Add To Bag",
                        size: 22,
                        colors: white,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 36,
                      color: purple.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
