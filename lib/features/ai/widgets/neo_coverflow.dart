import 'dart:math';
import 'package:flutter/material.dart';

class NeoCoverFlow extends StatefulWidget {
  final int itemCount;

  final Widget Function(BuildContext context, int index, bool selected)
  itemBuilder;

  const NeoCoverFlow({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<NeoCoverFlow> createState() => _NeoCoverFlowState();
}

class _NeoCoverFlowState extends State<NeoCoverFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double page = 1;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  void animateTo(int index) {
    controller.stop();

    final animation = Tween(
      begin: page,
      end: index.toDouble(),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    animation.addListener(() {
      setState(() {
        page = animation.value;
      });
    });

    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            page -= details.delta.dx / 280;
            page = page.clamp(0, widget.itemCount - 1.0);
          });
        },

        onHorizontalDragEnd: (_) {
          animateTo(page.round());
        },

        child: Stack(
          alignment: Alignment.center,
          children: List.generate(widget.itemCount, (index) {
            final distance = index - page;

            final absDistance = distance.abs();

            final scale = max(.78, 1 - absDistance * .18);

            final opacity = max(.35, 1 - absDistance * .45);

            final translateX = distance * 220;

            final translateY = absDistance * 35;

            final rotation = distance * .28;

            final z = (1 - absDistance);

            return Positioned.fill(
              child: IgnorePointer(
                ignoring: absDistance > .8,
                child: Center(
                  child: Transform(
                    alignment: Alignment.center,

                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .0015)
                      ..translate(translateX, translateY)
                      ..rotateY(rotation)
                      ..scale(scale),

                    child: Opacity(
                      opacity: opacity,
                      child: SizedBox(
                        width: 300,
                        child: widget.itemBuilder(
                          context,
                          index,
                          absDistance < .45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
