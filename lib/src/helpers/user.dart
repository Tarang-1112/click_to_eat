import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firebaseFirestore.collection(collection).doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firebaseFirestore.collection(collection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserById(String id) async {
    final temp = await _firebaseFirestore.collection(collection).doc(id).get();
    //  then((doc) {
    //     return UserModel.fromSnapshot(doc);
    //   });
    return UserModel.fromSnapshot(temp);
  }

  void addToCart({String? userId, CartItemModel? cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firebaseFirestore.collection(collection).doc(userId).update({
      "CART": FieldValue.arrayUnion([cartItem!.toMap()])
    });
  }

  void removeFromCart({String? userId, CartItemModel? cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firebaseFirestore.collection(collection).doc(userId).update({
      "CART": FieldValue.arrayRemove([cartItem!.toMap()])
    });
  }
}
