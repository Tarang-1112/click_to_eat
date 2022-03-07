import 'dart:io';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import '../helpers/product.dart';
import '../models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productSearchFood = [];
  List<ProductModel> likedProduct = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController rating = TextEditingController();

  bool featured = false;
  File? productImage;
  final picker = ImagePicker();
  String? productImageFileName;
  ProductModel productModel = ProductModel(
    id: "Loading",
    name: "Loading",
    image: "",
    rates: 0,
    rating: 0,
    price: 0,
    restaurantId: "Loading",
    restaurantName: "Loading",
    category: "Loading",
    featured: true,
    description: "Loading",
  );

  ProductProvider.initialize() {
    _loadProducts();
    // searchProduct(productName: "k");
  }

  _loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({required String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({required String restaurantId}) async {
    productsByRestaurant.clear();
    productsByRestaurant =
        await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

  Future loadLikedProduct({required String id}) async {
    likedProduct.clear();
    likedProduct = await _productServices.getLikedProduct(id: id);
    notifyListeners();
  }

  Future searchProduct({String? productName}) async {
    productSearchFood =
        await _productServices.searchProducts(productName: productName);
    print("The Number of Products : ${productSearchFood.length}");
    notifyListeners();
  }

  Future<bool> uploadProduct(
      {String? category, String? restaurant, String? restaurantId}) async {
    try {
      String id = Uuid().v1();
      String imageUrl =
          await _uploadImageFile(imageFile: productImage, imageFileName: id);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rates": 0,
        "rating": 0.0,
        "price": double.parse(price.text.trim()),
        "restaurant": restaurant,
        "restaurantId": restaurantId,
        "description": description.text.trim(),
        "featured": featured,
        "category": category,
      };
      _productServices.createProduct(data: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> editProduct(
      {String? id, String? name, String? description, num? price}) async {
    _productServices.updateProduct(
        id: id, name: name, description: description, price: price);
    notifyListeners();
    return true;
  }

  Future<bool> deleteRestroProduct({String? id}) async {
    _productServices.deleteProduct(id: id);
    notifyListeners();
    return true;
  }

  void likeOrDislikeProduct(
      {String? userId, ProductModel? product, bool? liked}) async {
    if (liked!) {
      if (product!.userLikes.remove(userId)) {
        _productServices.likeOrDislikeProduct(
            id: product.id, userLikes: product.userLikes);
      } else {
        print("The user was not removed.");
      }
    } else {
      product!.userLikes.add(userId!);
      _productServices.likeOrDislikeProduct(
          id: product.id, userLikes: product.userLikes);
    }
  }

  void rateProduct({String? id, num? rating}) async {
    _productServices.rateProduct(id: id, rating: rating);
    notifyListeners();
  }

  changeFeatured() {
    featured = !featured;
    notifyListeners();
  }

  getImageFile({ImageSource? source}) async {
    final pickedFile =
        await picker.getImage(source: source!, maxHeight: 400, maxWidth: 640);
    productImage = File(pickedFile!.path);
    productImageFileName =
        productImage!.path.substring(productImage!.path.indexOf('/') + 1);
    notifyListeners();
  }

  Future _uploadImageFile({File? imageFile, String? imageFileName}) async {
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName!);
    firebase_storage.UploadTask uploadTask = reference.putFile(imageFile!);
    String imageUrl =
        await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    return imageUrl;
  }

  clear() {
    productImage = null;
    productImageFileName = null;
    name.text = "";
    description.text = "";
    price.text = "";
    rating.text = "";
  }
}
