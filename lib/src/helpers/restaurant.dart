import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firebaseFirestore.collection(collection).get().then((result) {
        List<RestaurantModel> restaurants = [];
        for (DocumentSnapshot<Map<String, dynamic>> restaurant in result.docs) {
          restaurants.add(RestaurantModel.fromSnapshot(restaurant));
        }
        return restaurants;
      });

  Future<RestaurantModel> getRestaurantById({String? id}) async {
    final temp = await _firebaseFirestore.collection(collection).doc(id).get();
    //  then((doc) {
    //     return UserModel.fromSnapshot(doc);
    //   });
    return RestaurantModel.fromSnapshot(temp);
  }

  Future<List<RestaurantModel>> searchRestaurant({String? restaurantName}) {
    String searchKey =
        restaurantName![0].toUpperCase() + restaurantName.substring(1);
    return _firebaseFirestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<RestaurantModel> searchedRestaurant = [];
          for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
            searchedRestaurant.add(RestaurantModel.fromSnapshot(product));
          }
          return searchedRestaurant;
        });
  }
}
