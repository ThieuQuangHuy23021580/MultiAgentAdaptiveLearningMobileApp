import 'package:flutter/material.dart';

class MessageInputController extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();

  bool get canSend => textController.text.trim().isNotEmpty;

  MessageInputController() {
    textController.addListener(notifyListeners);
  }

  void clear() {
    textController.clear();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
