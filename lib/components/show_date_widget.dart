import 'package:flutter/material.dart';

class ShowDateWidget {
  static Future<DateTime?> showDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime.now());
    if (pickedDate != null) {
      pickedDate;
    }
    return null;
  }
}
