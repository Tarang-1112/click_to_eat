// import 'package:cloud_firestore/cloud_firestore.dart';

// class CartItemModel {
//   static const ID = "id";
//   static const NAME = "name";
//   static const IMAGE = "image";
//   static const PRODUCT_ID = "productId";
//   static const QUANTITY = "quantity";
//   static const PRICE = "price";
//   static const RESTAURANT_ID = "restaurantId";
//   static const TOTAL_RESTAURANT_SALES = "totalRestaurantSale";

//   String? _id;
//   String? _name;
//   String? _image;
//   String? _productId;
//   String? _restaurantId;
//   //int? _totalRestaurantSale;
//   int? _quantity;
//   int? _price;

//   //  getters
//   String? get id => _id;

//   String? get name => _name;

//   String? get image => _image;

//   String? get productId => _productId;

//   String? get restaurantId => _restaurantId;

//   int? get price => _price;

//   //int? get totalRestaurantSale => _totalRestaurantSale;

//   int? get quantity => _quantity;

//   CartItemModel.fromMap(Map data){
//     _id = data[ID];
//     _name =  data[NAME];
//     _image =  data[IMAGE];
//     _productId = data[PRODUCT_ID];
//     _price = data[PRICE];
//     _quantity = data[QUANTITY];
//     //_totalRestaurantSale = data[TOTAL_RESTAURANT_SALES];
//     _restaurantId = data[RESTAURANT_ID];
//   }

//   Map toMap() => {
//     ID: _id,
//     IMAGE: _image,
//     NAME: _name,
//     PRODUCT_ID: _productId,
//     QUANTITY: _quantity,
//     PRICE: _price,
//     RESTAURANT_ID: _restaurantId,
//    // TOTAL_RESTAURANT_SALES: _totalRestaurantSale
//   };
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id;
  final String name;
  final String image;
  final String productId;
  final int quantity;
  final int price;
  final String restaurantId;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.restaurantId,
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

  factory CartItemModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return CartItemModel(
      id: snapshot["id"] ?? "",
      name: snapshot["name"] ?? "",
      image: snapshot["image"] ?? "",
      productId: snapshot["productId"] ?? "",
      price: snapshot["price"] ?? 0,
      quantity: snapshot["quantity"] ?? 0,
      restaurantId: snapshot["restaurantId"],
    );
  }
  Map toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "productId": productId,
        "quantity": quantity,
        "price": price,
        "restaurantId": restaurantId,
        // TOTAL_RESTAURANT_SALES: _totalRestaurantSale
      };
}
