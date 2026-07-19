import 'package:flutter/material.dart';

Future<String?> showSessionInputDialog({
  required BuildContext context,
  required String title,
  required String label,
  required String initialValue,
  required String confirmLabel,
  int maxLines = 1,
}) {
  final controller = TextEditingController(text: initialValue);

  return showDialog<String>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: maxLines,
          decoration: InputDecoration(labelText: label),
          textInputAction: maxLines == 1
              ? TextInputAction.done
              : TextInputAction.newline,
          onSubmitted: maxLines == 1
              ? (value) => Navigator.pop(context, value)
              : null,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  ).whenComplete(controller.dispose);
}

Future<bool> showDeleteSessionDialog({
  required BuildContext context,
  required String sessionTitle,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Delete session'),
            content: Text('Delete "$sessionTitle" and its session record?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xffDC2626),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      ) ??
      false;
}
