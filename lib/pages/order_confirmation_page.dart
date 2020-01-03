import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';


class OrderConfirmationPage extends StatefulWidget {
  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  bool stop=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 20), (){});
    setState(() {
      stop=true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor("images/flare/SuccessCheck.flr",
            alignment:Alignment.center,
            fit:BoxFit.contain,
            animation:stop==false?"Untitled":"idle",
            
        ),
    );
  }
}