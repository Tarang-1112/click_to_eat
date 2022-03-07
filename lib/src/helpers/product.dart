import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/products.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createProduct({Map? data}) async {
    _firestore.collection(collection).doc(data!['id']).set({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "rates": data['rates'],
      "rating": data['rating'],
      "price": data['price'],
      "restaurant": data['restaurant'],
      "restaurantId": data['restaurantId'],
      "description": data['description'],
      "featured": data['featured'],
      "category": data["category"],
    });
  }

  void updateProduct(
      {String? id, String? name, String? description, num? price}) async {
    print(id);
    _firestore.collection(collection).doc(id).update({
      "name": name,
      "description": description,
      "price": price,
    }).then((value) {
      print(id);
      print("Success");
    });
  }

  void deleteProduct({String? id}) {
    _firestore.collection(collection).doc(id).delete().then((value) {
      print("Delete Sucesses");
    });
  }

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductsByRestaurant(
          {required String id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getLikedProduct({required String id}) async =>
      _firestore
          .collection(collection)
          .where("userLikes", arrayContains: id)
          .get()
          .then((result) {
        List<ProductModel> likedProducts = [];
        for (DocumentSnapshot<Map<String, dynamic>> likedProduct
            in result.docs) {
          likedProducts.add(ProductModel.fromSnapshot(likedProduct));
        }
        return likedProducts;
      });

  Future<List<ProductModel>> getProductsOfCategory(
          {required String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String? productName}) {
    String searchKey = productName![0].toUpperCase() + productName.substring(1);

    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> searchedproducts = [];
          for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
            searchedproducts.add(ProductModel.fromSnapshot(product));
          }
          return searchedproducts;
        });
  }

  void likeOrDislikeProduct({String? id, List<String>? userLikes}) {
    _firestore.collection(collection).doc(id).update({"userLikes": userLikes});
  }

  void rateProduct({String? id, num? rating}) {
    _firestore.collection(collection).doc(id).update({
      "rates": FieldValue.increment(1),
      "rating": FieldValue.increment(rating!),
    });
  }
}
