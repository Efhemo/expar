import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/utils/palette.dart';

class CustomTextInput extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLines;
  final String? errorText;

  const CustomTextInput({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLines,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Text(labelText!,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillGrey,
              hintText: hintText,
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: strokeGrey, width: 1),
              ),
              prefixIcon: prefixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
