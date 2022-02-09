import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/screens/details.dart';
import 'package:flutter/material.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

List<Product> productsList = [
  Product(
      id: "1",
      name: "Noodles",
      image: "noodles.jpg",
      rates: 100,
      rating: 4.2,
      price: 120,
      restaurantId: "a",
      restaurantName: "Food Junction",
      category: "Fast Food",
      featured: true),
  Product(
      id: "2",
      name: "Ceaser Salad",
      image: "2.jpg",
      rates: 100,
      rating: 4.3,
      price: 90,
      restaurantId: "b",
      restaurantName: "SubWay",
      category: "Healthy Food",
      featured: false),
  Product(
      id: "3",
      name: "Gujarati Thali",
      image: "3.jpg",
      rates: 100,
      rating: 4.5,
      price: 200,
      restaurantId: "c",
      restaurantName: "Kansaar Restaurant",
      category: "Thali",
      featured: true),
  Product(
      id: "4",
      name: "Fish Dish",
      image: "4.jpg",
      rates: 100,
      rating: 4.22,
      price: 200,
      restaurantId: "d",
      restaurantName: "Indian Restaurant",
      category: "Sea Food",
      featured: true),
  Product(
      id: "5",
      name: "Burger",
      image: "5.jpg",
      rates: 100,
      rating: 4.12,
      price: 40,
      restaurantId: "e",
      restaurantName: "Food Junction",
      category: "Fast Food",
      featured: true),
];

class Featured extends StatelessWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productsList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 16, 12),
              child: GestureDetector(
                onTap: () {
                  changeScreen(
                      _,
                      Details(
                        product: productsList[index],
                      ));
                },
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade50,
                        offset: Offset(15, 5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/${productsList[index].image}",
                        height: 140,
                        //width: 140,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                                text: "${productsList[index].name}",
                                size: 16,
                                colors: black,
                                weight: FontWeight.normal),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: productsList[index].featured
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
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                    text: "${productsList[index].rating}",
                                    size: 14,
                                    colors: grey,
                                    weight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: grey,
                                size: 16,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomText(
                                text: "\u{20B9}${productsList[index].price}",
                                size: 16,
                                colors: black,
                                weight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}