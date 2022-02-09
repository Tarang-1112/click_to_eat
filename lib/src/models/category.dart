import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return CategoryModel(
        id: snapshot.data()!["id"] ?? "",
        name: snapshot.data()!["name"] ?? "",
        image: snapshot.data()!["image"] ?? "");
  }
}
