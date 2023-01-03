import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final Widget leading;
  final Color backgroundColor;
  final Function() onBackTap;
  final List<Widget>? actions;

  const AppBarWidget({
    Key? key,
    this.title,
    this.actions,
    required this.onBackTap,
    this.backgroundColor = Colors.white,
    this.leading = const Icon(Icons.arrow_back, color: Colors.black),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: actions,
        backgroundColor: backgroundColor,
        title: Text(
          title ?? "",
          style: const TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
            onTap: () {
              onBackTap();
            },
            child: leading),
      ),
    );
  }
}
