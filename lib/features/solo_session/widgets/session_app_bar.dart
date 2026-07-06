import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../cores/theme/app_colors.dart';

class SessionAppBar extends StatefulWidget {
  const SessionAppBar({super.key});

  @override
  State<SessionAppBar> createState() => _SessionAppBarState();
}

class _SessionAppBarState extends State<SessionAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(.85)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IconButton(
        splashRadius: 24,
        icon: Icon(icon, color: Colors.grey.shade700),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Row(
        children: [
          _circleButton(
            icon: Icons.close,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffEAF2FF),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white.withOpacity(.8)),
            ),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return CustomPaint(
                      painter: _PulsePainter(_controller.value),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 10),

                const Text(
                  "Session Active",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          _circleButton(icon: Icons.more_horiz, onPressed: () {}),
        ],
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double value;

  _PulsePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = 5 + value * 12;

    final paint = Paint()
      ..color = AppColors.primary.withOpacity((1 - value) * .35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
