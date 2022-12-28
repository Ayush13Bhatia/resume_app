import 'package:flutter/material.dart';

class ShowResumeDateWidget {
  static Future<DateTime?> showDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1950),
        lastDate: lastDate ?? DateTime.now());
    if (pickedDate != null) {
      return pickedDate;
    }
    return null;
  }
}
