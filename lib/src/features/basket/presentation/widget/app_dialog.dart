import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    super.key,
  });

  final String title;

  static Future<void> show({
    required BuildContext context,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
