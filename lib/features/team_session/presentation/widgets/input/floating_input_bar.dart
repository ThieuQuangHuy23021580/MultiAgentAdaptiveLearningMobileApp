import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../cores/theme/app_colors.dart';
import 'message_input_controller.dart';
import 'send_button.dart';

class FloatingInputBar extends StatefulWidget {
  final Function(String text) onSend;

  const FloatingInputBar({super.key, required this.onSend});

  @override
  State<FloatingInputBar> createState() => _FloatingInputBarState();
}

class _FloatingInputBarState extends State<FloatingInputBar> {
  late final MessageInputController controller;

  @override
  void initState() {
    super.initState();
    controller = MessageInputController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void send() {
    final text = controller.textController.text.trim();

    if (text.isEmpty) return;

    widget.onSend(text);

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white.withOpacity(.45)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // TODO: Open document picker
                        },
                        borderRadius: BorderRadius.circular(22),
                        child: Ink(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.attach_file_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Guide the team or ask a question...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      SendButton(enabled: controller.canSend, onPressed: send),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
