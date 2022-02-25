import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String description;
  // final String productId;
  static const CART = "cart";
  final String userId;
  final num total;
  final String status;
  final int createdAt;
  final String restaurantId;
  //static const CREATED_AT = "createdAt";

  OrderModel({
    required this.id,
    required this.description,
    // required this.productId,
    this.cart,
    required this.userId,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.restaurantId,
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

  List<CartItemModel>? cart;

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    List<CartItemModel> ca = [];
    snapshot
        .data()!["CART"]
        .forEach((item) => ca.add(CartItemModel.fromSnapshot(item)));
    return OrderModel(
      id: snapshot.data()!["id"] ?? "",
      description: snapshot.data()!["description"] ?? "",
      //  productId: snapshot.data()!["productId"] ?? "",
      cart: ca, //snapshot.data()!["CART"],
      userId: snapshot.data()!["userId"] ?? "",
      total: snapshot.data()!["total"] ?? 0,
      status: snapshot.data()!["status"] ?? "",
      createdAt: snapshot.data()!["createdAt"] ?? 0,
      restaurantId: snapshot.data()!["restaurantId"] ?? "",
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
