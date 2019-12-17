import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';

class PaymentInfoModal extends StatelessWidget {
  final Function paymentHandler;
  final String email, phone, address;

  PaymentInfoModal(
      {@required this.paymentHandler,
      this.email = "",
      this.phone = "How do we call you?",
      this.address = "Where do we reach you?"});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: <Widget>[
              email.length == 0
                  ? Container()
                  : Container(
                      child: Text("Email", style: TextStyle(fontSize: 25))),
              SizedBox(height: email.length == 0 ? 0 : 10),
              email.length == 0 ? Container() : Container(child: Text(email)),
              SizedBox(height: email.length == 0 ? 0 : 20),
              Container(
                  child: Text("Phone", style: TextStyle(fontSize: 18)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Container(
                  child: Text("+91 "+User.phone, style: TextStyle(fontSize: 16)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 20),
              Container(
                  child: Text("Address", style: TextStyle(fontSize: 18)),
                  alignment: Alignment.centerLeft),
              SizedBox(height: 10),
              Container(
                  child: Wrap(children: <Widget>[
                    Text(address, style: TextStyle(fontSize: 18))
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
