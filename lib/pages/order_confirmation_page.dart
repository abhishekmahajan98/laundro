import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:laundro/model/screen_model.dart';

class OrderConfirmationPage extends StatefulWidget {
  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 20), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: FlareActor(
              "images/flare/SuccessCheck.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "Untitled",
            ),
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              HomeIdx.selectedIndex = 0;
            },
            child: Text('Go to home page'),
          )
        ],
      ),
    );
  }
}
