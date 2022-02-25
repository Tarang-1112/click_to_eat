import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestroOrderScreen extends StatefulWidget {
  const RestroOrderScreen({Key? key}) : super(key: key);

  @override
  _RestroOrderScreenState createState() => _RestroOrderScreenState();
}

class _RestroOrderScreenState extends State<RestroOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final restroAdminProvider = Provider.of<RestroAdminProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: grey),
        backgroundColor: black,
        elevation: 0.0,
        title: CustomText(
          text: "Orders",
          colors: white,
          size: 16,
          weight: FontWeight.normal,
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: black,
      body: ListView.builder(
        itemCount: restroAdminProvider.cartItems.length,
        itemBuilder: (_, index) {
          List<CartItemModel> cart = restroAdminProvider.cartItems;
          return ListTile(
            tileColor: black,
            leading: CustomText(
              text: "\u{20B9}${cart[index].totalRestaurantSale}",
              weight: FontWeight.bold,
              colors: white,
              size: 16,
            ),
            title: CustomText(
              text: cart[index].name,
              size: 16,
              colors: white,
              weight: FontWeight.bold,
            ),
            subtitle: CustomText(
              text: DateTime.now().toString(),
              size: 14,
              colors: white,
              weight: FontWeight.normal,
            ),
          );
        },
      ),
    );
  }
}
