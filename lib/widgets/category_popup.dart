import 'package:flutter/material.dart';

class CategoryPopup extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onChanged;
  final Function(String) addCategory;

  const CategoryPopup({
   super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
    required this.addCategory,
  });

  @override
  State<CategoryPopup> createState() => _CategoryPopupState();
}

class _CategoryPopupState extends State<CategoryPopup> {
  final TextEditingController _newCategoryController = TextEditingController();

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: SizedBox.shrink()),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add New Category'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _newCategoryController,
                            decoration: const InputDecoration(
                              labelText: 'Category Name',
                              hintText: 'Enter category name',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final newCategory = _newCategoryController.text;
                            if (newCategory.isNotEmpty) {
                              widget.addCategory(newCategory);
                            }
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
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
            )
          ],),
          Text(
            'Recently used categories',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    widget.onChanged(category);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
