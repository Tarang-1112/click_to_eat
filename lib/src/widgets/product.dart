import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/screens/restaurant.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final user = Provider.of<UserProvider>(context);
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
              width: 140,
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
                      image: widget.productModel.image,
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
                          text: widget.productModel.name,
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
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.productModel.liked =
                                      !widget.productModel.liked;
                                });
                                productProvider.likeOrDislikeProduct(
                                  userId: user.userModel!.id,
                                  product: widget.productModel,
                                  liked: widget.productModel.liked,
                                );
                                productProvider.loadLikedProduct(
                                    id: user.userModel!.id);
                              },
                              child: !widget.productModel.liked
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: <Widget>[
                        CustomText(
                          text: "From: ",
                          colors: grey,
                          weight: FontWeight.w600,
                          size: 14,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await productProvider.loadProductsByRestaurant(
                                restaurantId: widget.productModel.restaurantId);
                            await restaurantProvider.loadSingleRestaurant(
                                restaurantId: widget.productModel.restaurantId);
                            changeScreen(
                                context,
                                RestaurantScreen(
                                    restaurantModel:
                                        restaurantProvider.restaurant));
                          },
                          child: CustomText(
                            text: widget.productModel.restaurantName,
                            colors: primary,
                            weight: FontWeight.w500,
                            size: 11,
                          ),
                        ),
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
                              text: widget.productModel.rating.toString(),
                              colors: grey,
                              size: 14.0,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "\u{20B9}${widget.productModel.price}",
                          colors: black,
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                      ),
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
