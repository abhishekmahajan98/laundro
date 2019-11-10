import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Map<dynamic, dynamic> item;
  final Key index;

  CartItem({this.item, this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(item["title"]),
        subtitle: Text("Rs." +
            item["price"].toString() +
            " x " +
            item["qty"].toString() +
            " qty"),
        leading:
            CircleAvatar(child: Text(item["tag"].toString().substring(0, 2))),
        trailing: Text("Rs." + (item["price"] * item["qty"]).toString()),
        onTap: () {
          Navigator.pushReplacementNamed(context, "/" + item["tag"].toString());
        });
  }
}
