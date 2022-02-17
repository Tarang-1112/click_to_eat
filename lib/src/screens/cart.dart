import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Shopping Cart",
          colors: black,
          size: 16,
          weight: FontWeight.normal,
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.userModel!.cart!.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30)
                    ]),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        user.userModel!.cart![index].image,
                        height: 120,
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      user.userModel!.cart![index].name + "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "\$${user.userModel!.cart![index].price} \n\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                                TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: user.userModel!.cart![index].quantity
                                      .toString(),
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: red,
                            ),
                            onPressed: () async {
                              app.changeLoading();
                              bool value = await user.removeFromCart(
                                  cartItem: user.userModel!.cart![index]);
                              if (value) {
                                user.reloadUserModel();
                                print("Item added to cart");
                                _key.currentState!.showSnackBar(SnackBar(
                                    content: Text("Removed from Cart!")));
                                app.changeLoading();
                                return;
                              } else {
                                print("ITEM WAS NOT REMOVED");
                                app.changeLoading();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: " \$${user.userModel!.totalCartPrice}",
                      style: TextStyle(
                          color: primary,
                          fontSize: 22,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: FlatButton(
                  onPressed: () {
                    if (user.userModel!.totalCartPrice == 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          "Your Cart is Empty.",
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'You will be charged \$${user.userModel!.totalCartPrice! / 100} upon delivery!',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: const Color(0xFF1BC0C5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Reject",
                                            style:
                                                TextStyle(color: Colors.white),
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
                  child: CustomText(
                    text: "Check out",
                    size: 20,
                    colors: white,
                    weight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:click_to_eat/src/helpers/style.dart';
// import 'package:click_to_eat/src/providers/app.dart';
// import 'package:click_to_eat/src/providers/user.dart';
// import 'package:click_to_eat/src/widgets/custom_text.dart';
// import 'package:click_to_eat/src/models/products.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final _key = GlobalKey<ScaffoldState>();
//   ProductModel product = ProductModel(
//     id: "1",
//     name: "Noodles",
//     image: "noodles.jpg",
//     rates: 100,
//     rating: 4.2,
//     price: 120,
//     restaurantId: "a",
//     restaurantName: "Food Junction",
//     category: "Fast Food",
//     featured: true,
//     description:
//         "Noodles are a type of food made from unleavened dough which is rolled flat and cut, stretched or extruded, into long strips or strings. Noodles can be refrigerated for short-term storage or dried and stored for future use. Noodles are usually cooked in boiling water, sometimes with cooking oil or salt added.",
//   );
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context);
//     final app = Provider.of<AppProvider>(context);
//     return Scaffold(
//       key: _key,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: black),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         backgroundColor: white,
//         elevation: 0,
//         centerTitle: true,
//         title: CustomText(
//           text: "Shopping Bag",
//           size: 16,
//           colors: black,
//           weight: FontWeight.normal,
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset(
//                     "images/shopping_bag.jpg",
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 Positioned(
//                   right: 11,
//                   bottom: 4,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: grey.shade400,
//                             offset: Offset(2, 1),
//                             blurRadius: 3,
//                           ),
//                         ]),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4, right: 4),
//                       child: CustomText(
//                           text: "2",
//                           size: 16,
//                           colors: purple.shade700,
//                           weight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: white,
//       body: Builder(
//         builder: (context) {
//           return ListView(
            
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: purple.shade100,
//                         offset: Offset(3, 5),
//                         blurRadius: 30,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Image.asset(
//                         "images/${product.image}",
//                         height: 120,
//                         width: 120,
//                         //width: 140,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: product.name + "\n",
//                                   style: TextStyle(
//                                     color: black,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text:
//                                       "\u{20B9}" + product.price.toString() + "\n",
//                                   style: TextStyle(
//                                       color: black,
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 125,
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.delete),
//                             color: red,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }
