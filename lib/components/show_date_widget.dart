import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowDateWidget {
  static Future<DateTime?> showDate(BuildContext context) async {
    // DateTime? pickedDate =
    return showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2025));

    // String formattedDate = DateFormat("dd-MM-yyy").format(pickedDate!);
    //
    // return formattedDate;
  }
}
