import 'package:flutter/material.dart';
import 'package:resume_app1/utils/my_themes.dart';

class ElevationButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final IconData? icon;
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textStyleColor;
  final bool? showIcon;
  final EdgeInsetsGeometry? padding;

  const ElevationButtonWidget(
      {Key? key,
      this.showIcon = true,
      this.padding,
      this.iconColor,
      this.textStyleColor,
      this.borderColor,
      this.backgroundColor,
      this.icon,
      this.text,
      this.onPressed,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? MyThemes.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: borderColor ?? MyThemes.primary,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (showIcon == true)
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: MyThemes.primary,
                      ),
                      // color: MyThemes.primary,
                      child: Icon(
                        icon ?? Icons.remove_red_eye,
                        color: iconColor ?? MyThemes.white,
                      ),
                    )
                  : Container(),
              const SizedBox(
                width: 3,
              ),
              Text(
                text ?? "ADD",
                style: TextStyle(fontSize: 20, color: textStyleColor ?? MyThemes.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
