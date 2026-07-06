import 'package:flutter/material.dart';

enum ArtifactStatus { ready, generating }

class ArtifactItem {
  final String title;
  final IconData icon;
  final ArtifactStatus status;

  const ArtifactItem({
    required this.title,
    required this.icon,
    this.status = ArtifactStatus.ready,
  });
}
