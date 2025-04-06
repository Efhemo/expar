import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/Category.dart';
import 'package:myapp/utils/palette.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.onChanged,
  });

  final List<Category> categories;
  final Function(Category?) onChanged;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Category>.search(
      hintText: 'Select category',
      items: widget.categories,
      // initialItem: initialCategory,
      overlayHeight: 342,
      decoration: CustomDropdownDecoration(
        closedFillColor: fillGrey,
        closedBorderRadius: BorderRadius.circular(8.0),
        closedBorder: Border.all(color: strokeGrey, width: 1),
        expandedBorderRadius: BorderRadius.circular(8.0),
        expandedBorder: Border.all(color: strokeGrey, width: 1),
      ),
      onChanged: (value) {
        log('SearchDropdown onChanged value: \$value');
        widget.onChanged(value);
        setState(() {});
      },
    );
  }
}
