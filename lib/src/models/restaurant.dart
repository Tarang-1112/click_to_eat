import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final num id;
  final String name;
  final num averagePrice;
  //static const USER_ID = "userId";
  //final double price;
  final String image;
  final num rates;
  final num rating;
  final bool popular;
  //static const CREATED_AT = "createdAt";

  RestaurantModel({
    required this.id,
    required this.name,
    required this.averagePrice,
    //required this.price,
    required this.image,
    required this.rates,
    required this.rating,
    required this.popular,
  });

  // String _id = "";
  // String _description = "";
  // String _productId = "";
  // String _userId = "";
  // String _status = "";
  // int _createdAt = 0;
  // int _amount = 0;

//  getters
  // String get id => _id;
  // String get description => _description;
  // String get productId => _productId;
  // String get userId => _userId;
  // String get status => _status;
  // int get amount => _amount;
  // int get createdAt => _createdAt;

  factory RestaurantModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return RestaurantModel(
      id: snapshot.data()!["id"] ?? "",
      name: snapshot.data()!["name"] ?? "",
      averagePrice: snapshot.data()!["averagePrice"] ?? "",
      // price: snapshot.data()!["price"] ?? 0,
      image: snapshot.data()!["image"] ?? "",
      rates: snapshot.data()!["rates"] ?? 0,
      rating: snapshot.data()!["rating"] ?? 0,
      popular: snapshot.data()!["popular"] ?? false,
    );
  }

  // OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   _id = snapshot.data()!["ID"];
  //   _description = snapshot.data()!["DESCRIPTION"];
  //   _productId = snapshot.data()!["PRODUCT_ID"];
  //   _amount = snapshot.data()!["AMOUNT"];
  //   _status = snapshot.data()!["STATUS"];
  //   _userId = snapshot.data()!["USER_ID"];
  //   _createdAt = snapshot.data()!["CREATED_AT"];
  // }
}
