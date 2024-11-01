import 'package:flutter/material.dart';

class GreetingModule extends StatelessWidget {
  const GreetingModule({
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
          const TextSpan(
            text: 'What fruit salad combo do you want today?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
