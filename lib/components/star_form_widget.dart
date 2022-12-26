import 'package:flutter/material.dart';

class StarFormWidget extends StatelessWidget {
  final String? name;
  const StarFormWidget({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$name'),
        const Text(
          "*",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
