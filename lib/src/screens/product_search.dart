import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/screens/details.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: "Products",
          colors: black,
          size: 20,
          weight: FontWeight.normal,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
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
      body: productProvider.productSearchFood.length < 1
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
                        text: "No products Found",
                        size: 22,
                        colors: grey,
                        weight: FontWeight.w300)
                  ],
                ),
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productSearchFood.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    changeScreen(
                        context,
                        Details(
                          product: productProvider.productSearchFood[index],
                        ));
                  },
                  child: ProductWidget(
                      productModel: productProvider.productSearchFood[index]),
                );
              }),
    );
  }
}
