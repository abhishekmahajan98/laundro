import 'package:flutter/material.dart';


class CartPageItem extends StatelessWidget { 
  CartPageItem({
    this.selectedItem,
  });
  final Map selectedItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: Text(selectedItem['title']),
          subtitle: Text("Quantity = " +selectedItem['qty'].toString()),
          leading: CircleAvatar(child: Text("AZ")),
          trailing: Text('₹ '+selectedItem['total_item_cost'].toString()),
        );
  }
}