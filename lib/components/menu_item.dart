import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final int price, qty;
  final Function addQty, removeQty;

  MenuItem(
      {this.title = "title",
      this.price = 7,
      this.qty = 0,
      this.addQty,
      this.removeQty});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      ListTile(
          title: Text(title),
          subtitle: Text("Rs. " + price.toString()),
          //onTap: isPanelVisible,
          leading: CircleAvatar(child: Text("AZ")),
          trailing: SizedBox(
              width: qty > 0 ? 120 : 60,
              child: Row(
                children: <Widget>[
                  qty > 0
                      ? IconButton(
                          icon: Icon(Icons.remove), onPressed: removeQty)
                      : Container(),
                  Text(qty.toString()),
                  IconButton(icon: Icon(Icons.add), onPressed: addQty)
                ],
              ))),
      Divider()
    ]));
  }
}
