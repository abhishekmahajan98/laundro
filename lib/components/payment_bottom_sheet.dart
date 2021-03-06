import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:laundro/pages/order_confirm_buffer.dart';

class ShowPaymentBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      color: Color(0xfff2f3f7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Center(
                    child: Text(
                      'User Details',
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/address_update_page');
                      },
                      child: Text('Edit details'),
                    ),
                  ],
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: Text('+91-' + User.phone),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    title: Text(User.primaryAddress),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.landmark,
                      color: Colors.black,
                    ),
                    title: Text(User.landmark),
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          '₹',
                          style: TextStyle(fontSize: 25),
                        ),
                        title: Text('Payment Mode'),
                      ),
                      ListTile(
                        leading: Radio(
                          groupValue: Order.paymentType,
                          value: 'COD',
                          onChanged: (value) {
                            Order.paymentType = 'COD';
                          },
                        ),
                        title: Text(
                            'Cash on Delivery\n(UPI and wallets also available at delivery time)'),
                      ),
                      //TODO: IMPLEMENT PAYMENT GATEWAYS WITH RAZORPAY OR STRIPE
                      ListTile(
                        leading: Radio(
                          groupValue: Order.paymentType,
                          value: 'Online',
                          onChanged: null,
                        ),
                        title: Text(
                          'Online(card,wallets,UPI)',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        trailing: Text(
                          'Coming soon!!',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmBuffer(),
                  ),
                );
              },
              child: Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }
}
