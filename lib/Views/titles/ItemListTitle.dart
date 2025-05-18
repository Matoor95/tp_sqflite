import 'package:flutter/material.dart';
import 'package:tp_sqflite/Models/ItemList.dart';

class ItemListTitle extends StatelessWidget {
  ItemList itemList;
  Function(ItemList) onPressed;
  Function(ItemList) onDelete;

  ItemListTitle(
      {required this.itemList,
      required this.onDelete,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemList.name),
      onTap: (()=> onPressed(itemList)),
      trailing: IconButton(
        onPressed: (()=> onDelete(itemList)),
         icon: const Icon(Icons.delete)),
    );
  }
}
