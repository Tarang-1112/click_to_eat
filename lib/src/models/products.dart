import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String image;
  final num rates;
  final num rating;
  final num price;
  final String restaurantId;
  final String restaurantName;
  final String category;
  final bool featured;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rates,
    required this.rating,
    required this.price,
    required this.restaurantId,
    required this.restaurantName,
    required this.category,
    required this.featured,
    required this.description,
  });

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ProductModel(
      id: snapshot.data()!["id"] ?? "",
      name: snapshot.data()!["name"] ?? "",
      image: snapshot.data()!["image"] ?? "",
      rates: snapshot.data()!["rates"],
      rating: snapshot.data()!["rating"] ?? 0,
      price: snapshot.data()!["price"] ?? 0,
      restaurantId: snapshot.data()!["restaurantId"] ?? "",
      restaurantName: snapshot.data()!["restaurantName"] ?? "",
      category: snapshot.data()!["category"] ?? "",
      featured: snapshot.data()!["featured"] ?? false,
      description: snapshot.data()!["description"] ?? "",
    );
  }
}
