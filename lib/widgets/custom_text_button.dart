import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_button.dart';

import 'custom_text_input.dart';

class CustomTextButton extends StatefulWidget {
  final Function(String) addCategory;
  const CustomTextButton({super.key, required this.addCategory});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  final TextEditingController _newCategoryController = TextEditingController();

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text(
                'Add New Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      CustomTextInput(
                        labelText: 'Category',
                        hintText: 'Enter category name',
                        controller: _newCategoryController,
                      ),
                      SizedBox(height: 40),
                      CustomButton(
                        text: 'Save',
                        onPressed: () {
                          final newCategory = _newCategoryController.text;
                          if (newCategory.isNotEmpty) {
                            widget.addCategory(newCategory);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Row(
        children: [
          Icon(Icons.add, color: Colors.blue),
          Text('Add New', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }
}
