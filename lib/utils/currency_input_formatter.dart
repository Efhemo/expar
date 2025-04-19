import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Remove any non-numeric characters
    String cleanText = newText.replaceAll(RegExp(r'[^0-9.]'), '');

    // Parse the cleaned text as an integer
    double? parsedValue = double.tryParse(cleanText);

    if (parsedValue == null) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // Format the value as currency
    final formatter = NumberFormat("#,##0.00", "en_US");
    newText = formatter.format(parsedValue / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
