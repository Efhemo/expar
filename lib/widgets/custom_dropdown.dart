import 'package:flutter/material.dart';
import 'package:myapp/utils/palette.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? labelText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    super.key,
    this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Text(labelText!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: 5),

          DropdownButtonFormField<T>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: strokeGrey, width: 1),
              ),
            ),
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
