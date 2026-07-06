import 'package:flutter/material.dart';

class AgentAvatar extends StatelessWidget {
  final String image;

  const AgentAvatar({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xffEEF4FF),
        border: Border.all(color: Colors.grey.withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(child: Image.network(image, fit: BoxFit.cover)),
    );
  }
}
