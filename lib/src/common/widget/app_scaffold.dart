import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.resizeToAvoidBottomInset = true,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;
  final Widget body;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: body,
      ),
      drawer: drawer,
    );
  }
}
