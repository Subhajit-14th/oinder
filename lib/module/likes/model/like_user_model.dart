import 'package:flutter/material.dart';

class LikeUserModel {
  final String id;
  final String name;
  final int age;
  final String location;
  final double distance;
  final String image;
  final bool isLocked;
  final List<Color> gradient;

  const LikeUserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.distance,
    required this.image,
    required this.isLocked,
    required this.gradient,
  });
}
