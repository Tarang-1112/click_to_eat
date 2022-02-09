import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:flutter/material.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({Key? key}) : super(key: key);

  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  Product product = Product(
      id: "1",
      name: "Noodles",
      image: "noodles.jpg",
      rates: 100,
      rating: 4.2,
      price: 120,
      restaurantId: "a",
      restaurantName: "Food Junction",
      category: "Fast Food",
      featured: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Shopping Bag",
          size: 16,
          colors: black,
          weight: FontWeight.normal,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "images/shopping_bag.jpg",
                    height: 40,
                    width: 40,
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
                            color: grey.shade400,
                            offset: Offset(2, 1),
                            blurRadius: 3,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: CustomText(
                          text: "2",
                          size: 16,
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
      backgroundColor: white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: purple.shade100,
                    offset: Offset(3, 5),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "images/${product.image}",
                    height: 120,
                    width: 120,
                    //width: 140,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: product.name + "\n",
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "\u{20B9}" + product.price.toString() + "\n",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 125,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        color: red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
