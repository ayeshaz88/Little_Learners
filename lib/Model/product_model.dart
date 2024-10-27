import 'package:flutter/material.dart';

class Product {
  final String image,
      title,
      subtitle,
      event; // Add subtitle and event properties
  final int id, courses;
  final Color color;

  Product({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.event,
    required this.courses,
    required this.color,
    required this.id,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Reading",
    image: "assets/graphics.png",
    color: Color(0xFF71b8ff),
    courses: 16,
    subtitle: '',
    event: '',
  ),
  Product(
    id: 2,
    title: "General Knowledge",
    image: "assets/programming.png",
    color: Color(0xFFff6374),
    courses: 22,
    subtitle: '',
    event: '',
  ),
  Product(
    id: 3,
    title: "Drawing",
    image: "assets/finance.png",
    color: Color(0xFFffaa5b),
    courses: 15,
    subtitle: '',
    event: '',
  ),
  Product(
    id: 4,
    title: "Settings",
    image: "assets/ux.png",
    color: Color(0xFF9ba0fc),
    courses: 18,
    subtitle: '',
    event: '',
  ),
];
