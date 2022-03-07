import 'package:click_to_eat/src/helpers/order.dart';
import 'package:click_to_eat/src/helpers/product.dart';
import 'package:click_to_eat/src/helpers/restaurant.dart';
import 'package:click_to_eat/src/models/cart_item.dart';
import 'package:click_to_eat/src/models/orders.dart';
import 'package:click_to_eat/src/models/products.dart';
import 'package:click_to_eat/src/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class RestroAdminProvider with ChangeNotifier {
  FirebaseAuth? auth;
  User? user;
  RStatus? rstatus = RStatus.Uninitialized;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  RestaurantServices _restaurantServices = RestaurantServices();
  ProductServices _productServices = ProductServices();
  OrderServices _orderServices = OrderServices();
  num totalSales = 0;
  num avgPrice = 0;
  num restaurantRating = 0;
  bool isAdmin = true;

  RestaurantModel restaurantModel = RestaurantModel(
      id: "Loading",
      name: "Loading",
      averagePrice: 0,
      image: "https://c.tenor.com/I6kN-6X7nhAAAAAj/loading-buffering.gif",
      rates: 0,
      rating: 0,
      popular: false);

  List<ProductModel> products = <ProductModel>[];
  List<CartItemModel> cartItems = [];
  List<OrderModel> orders = [];

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();

  RestroAdminProvider.initialize() : auth = FirebaseAuth.instance {
    _onStateChanged(FirebaseAuth.instance.currentUser);
    getOrders();
  }

  Future<bool> signIn() async {
    try {
      rstatus = RStatus.Authenticating;
      notifyListeners();
      await auth!.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<bool> singUp() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      rstatus = RStatus.Authenticating;
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
          "isAdmin": true,
          // 'likedFood': [],
          // 'likedRestaurant': [],
        });
        _firebaseFirestore.collection("restaurants").doc(result.user!.uid).set({
          'name': name.text,
          'email': email.text,
          'id': result.user!.uid,
          "avgPrice": 0.0,
          "image": image.text,
          "popular": false,
          "rates": 0,
          "rating": 0.0,
          //"isAdmin": true,
          // 'likedFood': [],
          // 'likedRestaurant': [],
        });
      });
      await _prefs.setBool("isAdmin", true);
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  bool _onError(String error) {
    rstatus = RStatus.Unauthenticated;
    notifyListeners();
    print("Error :  $error");
    return false;
  }

  Future signOut() {
    auth!.signOut();
    rstatus = RStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      rstatus = RStatus.Unauthenticated;
    } else {
      user = firebaseUser;
      rstatus = RStatus.Authenticated;
      //final uid = FirebaseAuth.instance.currentUser!.uid;
      await loadProductsByRestaurant(restaurantId: user!.uid);
      await getOrders();
      await getTotalSales();
      await getAvgPrice();
      restaurantModel =
          await _restaurantServices.getRestaurantById(id: user!.uid);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> reload() async {
    restaurantModel =
        await _restaurantServices.getRestaurantById(id: user!.uid);
    await loadProductsByRestaurant(restaurantId: user!.uid);
    await getTotalSales();
    await getAvgPrice();
    await getOrders();

    notifyListeners();
  }

  Future loadProductsByRestaurant({required String restaurantId}) async {
    products = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

  getOrders() async {
    orders = await _orderServices.restaurantOrders(restaurantId: user!.uid);
  }

  getTotalSales() async {
    cartItems.clear();
    totalSales = 0;
    for (OrderModel order in orders) {
      for (CartItemModel item in order.cart!) {
        if (item.restaurantId == user!.uid) {
          totalSales = totalSales + item.totalRestaurantSale;
          cartItems.add(item);
        }
      }
    }
    totalSales = totalSales;
    notifyListeners();
  }

  getAvgPrice() async {
    if (products.length != 0) {
      num amountSum = 0;
      for (ProductModel product in products) {
        amountSum = amountSum + product.price;
      }
      avgPrice = (amountSum / products.length);
    }
    notifyListeners();
  }

  getRating() async {
    if (restaurantModel.rates != 0) {
      restaurantRating = restaurantModel.rating / restaurantModel.rates;
    }
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    image.text = "";
  }
}
