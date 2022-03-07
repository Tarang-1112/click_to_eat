import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/screens/details.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

// List<Product> productsList = [
//   Product(
//       id: "1",
//       name: "Noodles",
//       image: "noodles.jpg",
//       rates: 100,
//       rating: 4.2,
//       price: 120,
//       restaurantId: "a",
//       restaurantName: "Food Junction",
//       category: "Fast Food",
//       featured: true),
//   Product(
//       id: "2",
//       name: "Ceaser Salad",
//       image: "2.jpg",
//       rates: 100,
//       rating: 4.3,
//       price: 90,
//       restaurantId: "b",
//       restaurantName: "SubWay",
//       category: "Healthy Food",
//       featured: false),
//   Product(
//       id: "3",
//       name: "Gujarati Thali",
//       image: "3.jpg",
//       rates: 100,
//       rating: 4.5,
//       price: 200,
//       restaurantId: "c",
//       restaurantName: "Kansaar Restaurant",
//       category: "Thali",
//       featured: true),
//   Product(
//       id: "4",
//       name: "Fish Dish",
//       image: "4.jpg",
//       rates: 100,
//       rating: 4.22,
//       price: 200,
//       restaurantId: "d",
//       restaurantName: "Indian Restaurant",
//       category: "Sea Food",
//       featured: true),
//   Product(
//       id: "5",
//       name: "Burger",
//       image: "5.jpg",
//       rates: 100,
//       rating: 4.12,
//       price: 40,
//       restaurantId: "e",
//       restaurantName: "Food Junction",
//       category: "Fast Food",
//       featured: true),
// ];

class Featured extends StatefulWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Container(
      height: 225,
      //width: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 16, 12),
              child: GestureDetector(
                onTap: () {
                  changeScreen(
                      _,
                      Details(
                        product: productProvider.products[index],
                      ));
                },
                child: Container(
                  height: 325,
                  width: 240,
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
                      // Positioned.fill(
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: Container(
                      //       height: 120,
                      //       child: Loading(),
                      //     ),
                      //   ),
                      // ),
                      Stack(
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
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: productProvider.products[index].image,
                            height: 130,
                          ),
                        ],
                      ),
                      // Image.asset(
                      //   "images/${productProvider.products[index].image}",
                      //   height: 140,
                      //   //width: 140,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                                text: "${productProvider.products[index].name}",
                                size: 16,
                                colors: black,
                                weight: FontWeight.normal),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  productProvider.products[index].liked =
                                      !productProvider.products[index].liked;
                                });
                                productProvider.likeOrDislikeProduct(
                                  userId: user.userModel!.id,
                                  product: productProvider.products[index],
                                  liked: productProvider.products[index].liked,
                                );
                                productProvider.loadLikedProduct(
                                    id: user.userModel!.id);
                              },
                              child: !productProvider.products[index].liked
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
                                    text:
                                        "${productProvider.products[index].rating.toString()}",
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
                                text:
                                    "\u{20B9}${productProvider.products[index].price}",
                                size: 14,
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

/*
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
                        image: restaurant.image),
                  ),

*/