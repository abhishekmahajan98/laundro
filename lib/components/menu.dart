import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './menu_item.dart';

import '../Data.dart';

class Menu extends StatefulWidget {
  final String tag;

  Menu({@required this.tag});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SharedPreferences _prefs;
  List _menuItems = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      var data = await _prefs.get("menu_data");
      var tagData = await _prefs.get(widget.tag);
      List dataList;

      if (data == null) {
        var saved =
            await _prefs.setString("menu_data", json.encode(Database.dataItem));
        dataList = Database.dataItem;
        if (!saved) _showDialog();
      } else {
        if (Database.dataItem.length > json.decode(data).length) {
          var saved = await _prefs.setString(
              "menu_data", json.encode(Database.dataItem));
          dataList = Database.dataItem;
          if (!saved) _showDialog();
        } else {
          dataList = List.from(json.decode(data));
        }
      }

      if (tagData != null && json.decode(tagData).length > 0) {
        var data = await json.decode(tagData) ?? [];

        dataList = List<Map<dynamic, dynamic>>.from(dataList.map((item) {
          for (var i = 0; i < data.length; i++) {
            if (item["title"] == data[i]["title"]) {
              item["qty"] = data[i]["qty"];
            }
          }
          return item;
        }));
      }

      this.setState(() {
        _menuItems = dataList;
      });
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

  void saveToPrefs(dynamic items) async {
    var saved = await _prefs.setString(widget.tag, json.encode(items));
    if (!saved) _showDialog();
  }

  addItem(int i) {
    this.setState(() {
      _menuItems[i]["qty"] += 1;
    });
    var items = [];
    _menuItems.forEach((item) {
      if (item["qty"] > 0) {
        item["tag"] = widget.tag;
        items.add(item);
      }
    });
    saveToPrefs(items);
  }

  void removeItem(int i) {
    this.setState(() {
      _menuItems[i]["qty"] -= 1;
    });
    var items = [];
    _menuItems.forEach((item) {
      if (item["qty"] > 0) {
        item["tag"] = widget.tag;
        items.add(item);
      }
    });
    saveToPrefs(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tag),
        centerTitle: true,
      ),
        body: SafeArea(
            child: _menuItems.length == 0
                ? Center(child: CircularProgressIndicator())
                : Column(children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: _menuItems.length,
                          itemBuilder: (BuildContext context, int i) {
                            return MenuItem(
                              title: _menuItems[i]["title"],
                              qty: _menuItems[i]["qty"],
                              price: _menuItems[i]["price"],
                              addQty: () => addItem(i),
                              removeQty: () => removeItem(i),
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
