import 'package:click_to_eat/src/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String name = "name";
  String email = "email";
  String id = "id";
  String? stripeId = "stripeId";
  //List? likedRestaurant = []; //"likedFood";
  //static const liked_restaurant = "likedRestaurant";

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    this.stripeId,
    //this.likedRestaurant,
  });

  // String _name = "";
  // String _email = "";
  // String _id = "";

//getters
  // String get name => _name;
  // String get email => _email;
  // String get id => _id;

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      name: snapshot.data()!["name"] ?? "Tarang",
      email: snapshot.data()!["email"] ?? "Email",
      id: snapshot.data()!["uid"] ?? "",
      stripeId: snapshot.data()!["stripeId"] ?? "",
      // likedFood: snapshot.data()!["likedFood"] ?? [],
      // likedRestaurant: snapshot.data()!["likedRestaurant"] ?? [],
    );
  }
}
