import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String? hintText;
  final String? value;
  final Function(String?)? onChange;
  final String? textValue;
  final List<String> dropList;
  const DropDownWidget({Key? key, this.dropList = const [], this.hintText, this.textValue, this.value, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(
        '$textValue',
        textAlign: TextAlign.start,
      ),
      value: value,
      isDense: true,
      onChanged: onChange,
      alignment: Alignment.center,
      items: dropList
          .map(
            (String e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
    );
  }
}
