import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w300,
        ),
        children: [
          TextSpan(text: 'Hello $userName, '),
          TextSpan(
            text: 'What fruit salad combo do you want today?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
