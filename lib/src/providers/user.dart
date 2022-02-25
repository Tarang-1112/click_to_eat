import 'dart:async';
import 'package:click_to_eat/src/helpers/order.dart';
import 'package:click_to_eat/src/helpers/user.dart';
import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/models/orders.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  IsAdmin,
}

class UserProvider with ChangeNotifier {
  FirebaseAuth? auth;
  User? user;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserModel? userModel = UserModel(name: "Loading", email: "Loading", id: "");
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  Status status = Status.Uninitialized;

  //getters
  // UserModel? get userModel => _userModel;
  // Status get status => _status;
  // User get user => _user!;

  final formkey = GlobalKey<FormState>();

  List<OrderModel> orders = [];

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  bool? isAdmin;
  bool? isAdminSharedPref;

  void setIsAdmin() async {
    final _prefs = await SharedPreferences.getInstance();
    final isAdmin = _prefs.getBool('isAdmin');
    isAdminSharedPref = isAdmin;
    notifyListeners();
  }

  UserProvider.initialize() : auth = FirebaseAuth.instance {
    auth!.authStateChanges().listen((event) {
      _onStateChanged(FirebaseAuth.instance.currentUser);
    });
  }

  Future<bool> signIn() async {
    try {
      status = Status.Authenticating;
      notifyListeners();
      final result = await auth!.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      final user = await _userServices.getUserById(result.user!.uid);
      isAdmin = user.isAdmin;
      if (isAdmin!) {
        status = Status.IsAdmin;
      }
      final _prefs = await SharedPreferences.getInstance();
      _prefs.setBool('isAdmin', isAdmin!);
      notifyListeners();

      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<bool> singUp() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      status = Status.Authenticating;
      notifyListeners();
      await auth!
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firebaseFirestore.collection("users").doc(result.user!.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user!.uid,
          'CART': [],
          "isAdmin": false,
          // 'likedFood': [],
          // 'likedRestaurant': [],
        });
      });
      await _prefs.setBool('isAdmin', false);
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future signOut() {
    auth!.signOut();
    status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> reloadUserModel() async {
    userModel = await _userServices.getUserById(user!.uid);
    notifyListeners();
  }

  void cleanControllers() {
    email.text = "";
    password.text = "";
    name.text = "";
  }

  Future<void> _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      status = Status.Unauthenticated;
    } else {
      user = firebaseUser;
      final _prefs = await SharedPreferences.getInstance();
      final _isAdmin = _prefs.getBool('isAdmin');
      if (_isAdmin!) {
        status = Status.IsAdmin;
      } else {
        status = Status.Authenticated;
      }
      //final uid = FirebaseAuth.instance.currentUser!.uid;
      userModel = await _userServices.getUserById(user!.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel? product, num? quantity}) async {
    print("THE PRODUC IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel>? cart = userModel!.cart;
      print("hii");
      Map<String, dynamic> cartItem = {
        "id": cartItemId,
        "name": product!.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity!,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity,
      };
      print(cartItem);
      print("how");
      CartItemModel item = CartItemModel.fromSnapshot(cartItem);
      print(item);
      print("are");
      print("CART ITEMS ARE : ${cart.toString()}");
      _userServices.addToCart(userId: user!.uid, cartItem: item);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

//general methods
  bool _onError(String error) {
    status = Status.Unauthenticated;
    notifyListeners();
    print("Error :  $error");
    return false;
  }

  getOrders() async {
    orders = await _orderServices.getUsersOrder(userId: user!.uid);
  }

  Future<bool> removeFromCart({CartItemModel? cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: user!.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
}
