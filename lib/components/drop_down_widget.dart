import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String? hintText;
  final String? value;
  final Function(String?)? onChange;
  final String? textValue;
  final List<String> dropList;
  final String? Function(dynamic)? validation;
  const DropDownWidget({Key? key, this.validation, this.dropList = const [], this.hintText, this.textValue, this.value, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField(
          validator: validation,
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              // isEmpty: gender == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('$textValue'),
                  value: value,
                  isDense: true,
                  onChanged: onChange,
                  items: dropList
                      .map(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );

    //   DropdownButton<String>(
    //   hint: Text(
    //     '$textValue',
    //     textAlign: TextAlign.start,
    //   ),
    //   value: value,
    //   isDense: true,
    //   onChanged: onChange,
    //   alignment: Alignment.center,
    //   items: dropList
    //       .map(
    //         (String e) => DropdownMenuItem<String>(
    //           value: e,
    //           child: Text(e),
    //         ),
    //       )
    //       .toList(),
    // );
  }
}
