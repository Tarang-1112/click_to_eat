import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/models/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createOrder({
    String? userId,
    String? id,
    String? description,
    String? status,
    List<CartItemModel>? cart,
    num? totalPrice,
  }) {
    List<Map> convertedCart = [];
    List<String> restaurantIds = [];

    for (CartItemModel item in cart!) {
      convertedCart.add(item.toMap());
      restaurantIds.add(item.restaurantId);
    }

    _firebaseFirestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "restaurantIds": restaurantIds,
      "CART": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
    });
  }

  Future<List<OrderModel>> getUsersOrder({String? userId}) async =>
      _firebaseFirestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot<Map<String, dynamic>> order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
