import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/avatar.dart';

class TypingIndicator extends StatefulWidget {
  final String avatar;

  final String agent;

  const TypingIndicator({super.key, required this.avatar, required this.agent});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget dot(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final value = ((controller.value + index * .2) % 1);

        final scale = .6 + (value < .5 ? value : 1 - value) * .8;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff2563EB),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AgentAvatar(image: widget.avatar),

        const SizedBox(width: 14),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.agent,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xffE8F0FF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  dot(0),
                  const SizedBox(width: 6),
                  dot(1),
                  const SizedBox(width: 6),
                  dot(2),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
