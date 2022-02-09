import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final int rates;
  final double rating;
  final double price;
  final String restaurantId;
  final String restaurantName;
  final String category;
  final bool featured;

  Product({
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
  });

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Product(
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
    );
  }
}
