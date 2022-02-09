import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id;
  final String name;
  final String image;
  final String productId;
  final int quantity;
  final int price;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  // String _id = "";
  // String _name = "";
  // String _image = "";
  // String _productId = "";
  // int _quantity = 0;
  // int _price = 0;

  // //  getters
  // String get id => _id;

  // String get name => _name;

  // String get image => _image;

  // String get productId => _productId;

  // int get price => _price;

  // int get quantity => _quantity;

  factory CartItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return CartItemModel(
      id: snapshot.data()!["id"] ?? "",
      name: snapshot.data()!["name"] ?? "",
      image: snapshot.data()!["image"] ?? "",
      productId: snapshot.data()!["productId"] ?? "",
      price: snapshot.data()!["price"] ?? 0,
      quantity: snapshot.data()!["quantity"] ?? 0,
    );
  }
}
