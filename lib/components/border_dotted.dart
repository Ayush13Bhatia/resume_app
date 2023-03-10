import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../utils/my_themes.dart';

class BorderDotted extends StatelessWidget {
  final Function()? onTap;
  final String? borderName;
  const BorderDotted({Key? key, this.onTap, this.borderName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () => onTap!(),
        child: DottedBorder(
          color: MyThemes.primary,
          borderType: BorderType.RRect,
          dashPattern: const [16, 9],
          strokeWidth: 1,
          radius: const Radius.circular(15),
          // padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 100,
              width: double.infinity,
              color: MyThemes.primaryLight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload,
                      size: 60,
                      color: MyThemes.primary,
                    ),
                    Text(borderName ?? ""),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
