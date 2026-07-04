import 'package:flutter/material.dart';

class AgentModel {
  final String name;
  final String role;
  final String description;
  final String image;
  final IconData icon;

  const AgentModel({
    required this.name,
    required this.role,
    required this.description,
    required this.image,
    required this.icon,
  });
}
