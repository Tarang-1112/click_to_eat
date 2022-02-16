import 'package:flutter/material.dart';
import '../helpers/restaurant.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  RestaurantModel? restaurant;
  List<RestaurantModel> restaurantSearch = [];

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
}
