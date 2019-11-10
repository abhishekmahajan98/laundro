import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/cart_list.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items = [];
  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    _prefs = await SharedPreferences.getInstance();
    var iron = _prefs.getString("iron")==null?[]:json.decode(_prefs.getString("iron"));
    var wash = _prefs.getString("wash")==null?[]:json.decode(_prefs.getString("wash"));
    var dryClean = _prefs.getString("dry-clean")==null?[]:json.decode(_prefs.getString("dry-clean"));

    this.setState(() {
      items = [
        ...wash,
        ...iron,
        ...dryClean
      ];
    });
  }

  get getTotal {
    int total = 0;
    try{
      if (items.length > 0) {
        for (var i = 0; i < items.length; i++) {
          total += items[i]["qty"] * items[i]["price"];
        }
      }
    }catch(e){
      print(e);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: items.length == 0
          ? Container(child: Center(child: Text("No Items")))
          : Column(children: <Widget>[
              Expanded(child: CartList(list: items)),
              Container(
                  child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Total:", style: TextStyle(fontSize: 25)),
                          SizedBox(width: 20),
                          Text("Rs." + getTotal.toString(),
                              style: TextStyle(fontSize: 25))
                        ])),
                RaisedButton(
                    child: Text("Proceed To Payment"), onPressed: () {})
              ]))
            ])
    )));
  }
}
