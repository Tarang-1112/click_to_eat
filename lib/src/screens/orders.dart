import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/orders.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: grey,
        ),
        backgroundColor: black,
        elevation: 0.0,
        title: CustomText(
          text: "My Orders",
          colors: white,
          size: 20,
          weight: FontWeight.bold,
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
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = userProvider.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\u{20B9}${_order.total}",
                size: 16,
                colors: white,
                weight: FontWeight.bold,
              ),
              title: CustomText(
                text: _order.description,
                colors: white,
                size: 20,
                weight: FontWeight.bold,
              ),
              subtitle: CustomText(
                text:
                    "${DateTime.fromMillisecondsSinceEpoch(_order.createdAt)}",
                colors: white,
                size: 16,
                weight: FontWeight.bold,
              ),
              // subtitle: Text(
              //     DateTime.fromMillisecondsSinceEpoch(_order.createdAt)
              //         .toString()),
              trailing: CustomText(
                text: _order.status,
                colors: Colors.green,
                size: 16,
                weight: FontWeight.normal,
              ),
            );
          }),
    );
  }
}
