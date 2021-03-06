import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/screens/restaurant.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class RestroProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const RestroProductWidget({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantAdminProvider = Provider.of<RestroAdminProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: grey.shade300, offset: Offset(-2, -1), blurRadius: 5),
            ]),
        //            height: 160,
        child: Row(
          children: <Widget>[
            Container(
              width: 145,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
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
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: productModel.image,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: productModel.name,
                          colors: black,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                    color: grey.shade300,
                                    offset: Offset(1, 1),
                                    blurRadius: 4),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: red,
                              size: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: <Widget>[
                        // CustomText(
                        //   text: "From: ",
                        //   colors: grey,
                        //   weight: FontWeight.w600,
                        //   size: 14,
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(
                            text: "\u{20B9}${productModel.price}",
                            colors: black,
                            size: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     await productProvider.loadProductsByRestaurant(
                        //         restaurantId: productModel.restaurantId);
                        //     await restaurantProvider.loadSingleRestaurant(
                        //         restaurantId: productModel.restaurantId);
                        //     changeScreen(
                        //         context,
                        //         RestaurantScreen(
                        //             restaurantModel:
                        //                 restaurantProvider.restaurant));
                        //   },
                        //   child: CustomText(
                        //     text: productModel.restaurantName,
                        //     colors: primary,
                        //     weight: FontWeight.w500,
                        //     size: 14,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CustomText(
                              text: productModel.rating.toString(),
                              colors: grey,
                              size: 16.0,
                              weight: FontWeight.normal,
                            ),
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
                            color: grey,
                            size: 16,
                          ),
                        ],
                      ),
                      IconButton(
                        //iconSize: 5,
                        icon: Icon(
                          Icons.delete,
                          color: red,
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    height: 141,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Are You sure?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 320.0,
                                            child: RaisedButton(
                                              onPressed: () async {
                                                if (!await productProvider
                                                    .deleteRestroProduct(
                                                        id: productModel.id)) {
                                                  print("delete Faled");
                                                  return;
                                                }
                                                productProvider.clear();
                                                restaurantAdminProvider
                                                    .reload();
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 320.0,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 8.0),
                      //   child: CustomText(
                      //     text: "\u{20B9}${productModel.price}",
                      //     colors: black,
                      //     size: 14,
                      //     weight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
