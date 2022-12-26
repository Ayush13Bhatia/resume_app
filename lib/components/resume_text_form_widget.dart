import 'package:flutter/material.dart';
import 'package:resume_app1/components/star_form_widget.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? name;
  const TextFormWidget({Key? key, this.controller, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StarFormWidget(
          name: name,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "Please enter the text";
          //   }
          //   return null;
          // },
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: '$name',
          ),
          onChanged: (val) {},
        ),
      ],
    );
  }
}
