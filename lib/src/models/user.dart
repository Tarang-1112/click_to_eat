import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String name = "name";
  String email = "email";
  String id = "id";
  String? stripeId = "stripeId";
  static const CART = "cart";
  final bool? isAdmin;

  //List? likedRestaurant = []; //"likedFood";
  //static const liked_restaurant = "likedRestaurant";

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    this.stripeId,
    this.totalCartPrice,
    this.cart,
    this.isAdmin,
    //this.likedRestaurant,
  });

  num _priceSum = 0;
  num _quantitySum = 0;

  // String _name = "";
  // String _email = "";
  // String _id = "";

//getters
  // String get name => _name;
  // String get email => _email;
  // String get id => _id;

  List<CartItemModel>? cart = [];
  num? totalCartPrice = 0;

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    List<CartItemModel> ca = [];
    snapshot
        .data()!["CART"]
        .forEach((item) => ca.add(CartItemModel.fromSnapshot(item)));
    num total = 0;
    snapshot
        .data()!["CART"]
        .forEach((item) => total += item["price"] * item["quantity"]);
    return UserModel(
      name: snapshot.data()!["name"] ?? "Tarang",
      email: snapshot.data()!["email"] ?? "Email",
      id: snapshot.data()!["uid"] ?? "",
      stripeId: snapshot.data()!["stripeId"] ?? "",
      cart: ca,
      totalCartPrice: total,
      isAdmin: snapshot.data()!["isAdmin"],
      // likedFood: snapshot.data()!["likedFood"] ?? [],
      // likedRestaurant: snapshot.data()!["likedRestaurant"] ?? [],
    );
  }

//    num getTotalPrice({List? cart}){
//     if(cart == null){
//       return 0;
//     }
//     for(Map cartItem in cart){
//       _priceSum += cartItem["price"] * cartItem["quantity"];
//     }
//     num total = _priceSum;

//     print("THE TOTAL IS $total");
//     print("THE TOTAL IS $total");
//     print("THE TOTAL IS $total");
//     print("THE TOTAL IS $total");
//     print("THE TOTAL IS $total");

//     return total;
//   }

//  List<CartItemModel> _convertCartItems(List cart){
//     List<CartItemModel> convertedCart = [];
//     for(var cartItem in cart){
//       convertedCart.add(cartItem.fromMap(cartItem));
//     }
//     return convertedCart;
//   }
}
