import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item.dart';
import "package:shopping_list/data/dummy_items.dart";
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryitems = [];
  void _additem() async {
    final newItem = await Navigator.of(context)
        .push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryitems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryitems.remove(item);
    });
  }

  @override
  Widget build(context) {
    Widget content = Center(child: Text('NO items added yet'));
    if (_groceryitems.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryitems.length,
          itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryitems[index].id),
                onDismissed: (direction) {
                  _removeItem(_groceryitems[index]);
                },
                child: ListTile(
                  title: Text(_groceryitems[index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryitems[index].category.color,
                  ),
                  trailing: Text(_groceryitems[index].quantity.toString()),
                ),
              ));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Groceries"),
          actions: [
            IconButton(onPressed: _additem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
