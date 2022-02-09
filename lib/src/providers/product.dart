// import 'package:flutter/material.dart';
// import '../helpers/product.dart';
// import '../models/products.dart';

// class ProductProvider with ChangeNotifier {
//   ProductServices _productServices = ProductServices();
//   List<Product> products = [];
//   List<Product> productsByCategory = [];
//   List<Product> productsByRestaurant = [];

//   ProductProvider.initialize() {
//     _loadProducts();
//   }

//   _loadProducts() async {
//     products = await _productServices.getProducts();
//     notifyListeners();
//   }

//   Future loadProductsByCategory({required String categoryName}) async {
//     productsByCategory =
//         await _productServices.getProductsOfCategory(category: categoryName);
//     notifyListeners();
//   }

//   Future loadProductsByRestaurant({required int restaurantId}) async {
//     productsByRestaurant =
//         await _productServices.getProductsByRestaurant(id: restaurantId);
//     notifyListeners();
//   }
// }
