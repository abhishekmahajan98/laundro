import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:laundro/constants.dart';
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
          Text(
            'Order Placed Successfully',
            style: TextStyle(
              color: mainColor,
              fontSize: MediaQuery.of(context).size.height / 35,
            ),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FlareActor(
                "images/flare/SuccessCheck.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "Untitled",
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: mainColor,
                onPressed: () {
                  Navigator.pop(context);
                  HomeIdx.selectedIndex = 0;
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
