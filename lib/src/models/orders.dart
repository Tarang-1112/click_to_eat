import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String description;
  final String productId;
  final String userId;
  final int amount;
  final String status;
  final int createdAt;
  //static const CREATED_AT = "createdAt";

  OrderModel({
    required this.id,
    required this.description,
    required this.productId,
    required this.userId,
    required this.amount,
    required this.status,
    required this.createdAt,
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

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return OrderModel(
      id: snapshot.data()!["id"] ?? "",
      description: snapshot.data()!["description"] ?? "",
      productId: snapshot.data()!["productId"] ?? "",
      userId: snapshot.data()!["userId"] ?? "",
      amount: snapshot.data()!["amount"] ?? 0,
      status: snapshot.data()!["status"] ?? "",
      createdAt: snapshot.data()!["createdAt"] ?? 0,
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
