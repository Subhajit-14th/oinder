import 'package:flutter/material.dart';

class ExploreModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  const ExploreModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });
}
