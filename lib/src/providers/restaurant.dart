import 'package:flutter/material.dart';
import '../helpers/restaurant.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  RestaurantModel? restaurant;
  List<RestaurantModel> restaurantSearch = [];
  List<RestaurantModel> likedRestaurants = [];

  RestaurantProvider.initialize() {
    _loadRestaurants();
    //searchRaestro(restaurantName: "K");
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String? restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future searchRaestro({String? restaurantName}) async {
    restaurantSearch = await _restaurantServices.searchRestaurant(
        restaurantName: restaurantName);
    print("The Number of Restaurant : ${restaurantSearch.length}");
    notifyListeners();
  }

  Future loadLikedRestaurants({required String id}) async {
    likedRestaurants.clear();
    likedRestaurants = await _restaurantServices.getLikedRestaurant(id: id);
    notifyListeners();
  }

  void likeOrDislikeProduct(
      {String? userId, RestaurantModel? restaurant, bool? liked}) async {
    if (liked!) {
      if (restaurant!.userLikes.remove(userId)) {
        _restaurantServices.likeOrDislikeProduct(
            id: restaurant.id, userLikes: restaurant.userLikes);
      } else {
        print("The user was not removed.");
      }
    } else {
      restaurant!.userLikes.add(userId!);
      _restaurantServices.likeOrDislikeProduct(
          id: restaurant.id, userLikes: restaurant.userLikes);
    }
  }
}
