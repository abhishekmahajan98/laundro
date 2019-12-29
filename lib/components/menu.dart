import 'package:flutter/material.dart';
import 'package:laundro/model/items_model.dart';

import './menu_item.dart';

class Menu extends StatefulWidget {
  final String tag;

  Menu({@required this.tag});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Items items;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      items = await Items.getItemsPref(widget.tag);
    } catch (e) {
      print(e);
      _showDialog();
    }
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Something went wrong"),
            actions: <Widget>[
              FlatButton(
                  child: Text("Close"), onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  // void saveToPrefs() async {
  //   var saved = await items.setItemPref();
  //   if (!saved) _showDialog();
  // }

  // addItem(int i) {

  //   this.setState(() {
  //     _menuItems[i]["qty"] += 1;
  //   });
  //   var items = [];
  //   _menuItems.forEach((item) {
  //     if (item["qty"] > 0) {
  //       item["tag"] = widget.tag;
  //       items.add(item);
  //     }
  //   });
  //   saveToPrefs(items);
  // }

  // void removeItem(int i) {
  //   this.setState(() {
  //     _menuItems[i]["qty"] -= 1;
  //   });
  //   var items = [];
  //   _menuItems.forEach((item) {
  //     if (item["qty"] > 0) {
  //       item["tag"] = widget.tag;
  //       items.add(item);
  //     }
  //   });
  //   saveToPrefs(items);
  // }

  @override
  Widget build(BuildContext context) {
    final itemKeys = items.toJson().keys;
    final itemsMap = items.toJson();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tag),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: items.toJson().keys.length - 2,
                itemBuilder: (BuildContext context, int i) {
                  return MenuItem(
                    title: itemKeys.elementAt(i),
                    qty: itemsMap[itemKeys.elementAt(i)]["quantity"],
                    price: itemsMap[itemKeys.elementAt(i)]["quantity"]["price"],
                    // addQty: () => addItem(i),
                    // removeQty: () => removeItem(i),
                  );
                }),
          ),
          Container(
              width: 500,
              height: 50,
              child: RaisedButton(
                  child: Text("Checkout"),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/cart");
                  }))
        ])));
  }
}
