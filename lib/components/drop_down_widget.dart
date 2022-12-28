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
      hint: Text('$textValue'),
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

// class DropDownFormWidget extends StatelessWidget {
//   final String? hintText;
//   final Widget? suffixIcons;
//   final Widget? prefixIcon;
//   final double? radius;
//   final bool? isRequired;
//   final String? titleText;
//   final bool? isSearch;
//   final bool? isReadOnly;
//   final Function()? onTap;
//   final int? minLines;
//   final TextInputType? inputType;
//   final int? maxLength;
//   final void Function(String?)? onChanged;
//   final TextStyle? textStyle;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final List<String> items;
//   final InputDecoration? customDecoration;
//   final String? pattern;
//   const DropDownFormWidget({
//     Key? key,
//     this.titleText,
//     this.onChanged,
//     this.textStyle,
//     this.prefixIcon,
//     this.onTap,
//     this.isSearch = false,
//     this.inputType,
//     this.maxLength,
//     this.isRequired,
//     this.isReadOnly,
//     this.minLines,
//     this.hintText,
//     this.radius,
//     this.controller,
//     this.validator,
//     this.suffixIcons,
//     required this.items,
//     this.customDecoration,
//     this.pattern,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(),
//         DropdownButtonHideUnderline(
//           child: ButtonTheme(
//             alignedDropdown: true,
//             child: DropdownButtonFormField(
//               onChanged: onChanged ?? (st) {},
//               icon: const Center(
//                 child: Icon(Icons.keyboard_arrow_down),
//               ),
//               isDense: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     radius ?? 15,
//                   ),
//                 ),
//                 hintText: hintText,
//               ),
//               items: items.map((e) {
//                 return DropdownMenuItem(
//                   value: e,
//                   child: Text(e),
//                 );
//               }).toList(),
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
