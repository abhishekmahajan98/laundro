import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';

class PaymentInfoModal extends StatelessWidget {
  final Function paymentHandler;
  // final String email, phone, address;

  PaymentInfoModal(
      {@required this.paymentHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(
                      child: Text("Email", style: TextStyle(fontSize: 25))),
              Container(child: Text(User.email)),
              
              Container(
                  child: Text("Phone", style: TextStyle(fontSize: 18)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Container(
                  child: Text("+91 "+User.phone.toString(), style: TextStyle(fontSize: 16)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 20),
              Container(
                  child: Text("Address", style: TextStyle(fontSize: 18)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Container(
                  child: Wrap(children: <Widget>[
                    Text(User.primaryAddress.split("+").join(","), style: TextStyle(fontSize: 18))
                  ]),
                  alignment: Alignment.centerLeft),
            ]),
          )),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            height: 50,
            child: Text("Make payment", style: TextStyle(fontSize: 16)),
            color: Colors.green,
            textColor: Colors.white,
            onPressed: paymentHandler,
          )
        ]));
  }
}
