import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/restroAdmin/widget/restroProduct.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestroProductsScreen extends StatefulWidget {
  const RestroProductsScreen({Key? key}) : super(key: key);

  @override
  _RestroProductsScreenState createState() => _RestroProductsScreenState();
}

class _RestroProductsScreenState extends State<RestroProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final restaurantAdminProvider = Provider.of<RestroAdminProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: grey),
        backgroundColor: black,
        elevation: 0.0,
        title: CustomText(
          text: "Products",
          colors: white,
          size: 16,
          weight: FontWeight.bold,
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Column(
          children: restaurantAdminProvider.products
              .map((item) => GestureDetector(
                    onTap: () {},
                    child: RestroProductWidget(
                      productModel: item,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
