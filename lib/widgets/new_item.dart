import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import "package:shopping_list/model/category.dart";
import 'package:shopping_list/model/grocery_item.dart';

class NewItem extends StatefulWidget {
  @override
  State<NewItem> createState() {
    return _NewState();
  }
}

class _NewState extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enterdQuantity = 1;
  var _selectedCategory = categories[Categories.fruit]!;

  void _saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now.toString(),
          name: _enteredName,
          quantity: _enterdQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Value must be between 1 and 50';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                const SizedBox(
                    height: 16), // Added some spacing for better layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Quantity")),
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Value must be valid and positive number ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enterdQuantity = int.parse(value!);
                      },
                    )),
                    const SizedBox(width: 15),
                    Expanded(
                        child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title)
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("Resest")),
                    ElevatedButton(
                        onPressed: _saveItem, child: const Text("Submit"))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
