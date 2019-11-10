import 'package:flutter/material.dart';

import './cart_item.dart';

class CartList extends StatelessWidget {
  final List list;

  CartList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        return CartItem(item: list[i],index:Key(i.toString()));
      },
    );
  }
}
