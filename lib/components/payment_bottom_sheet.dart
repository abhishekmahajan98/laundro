import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';


class ShowPaymentBottom extends StatelessWidget {
  String getAddress(){
    if(User.primaryAddressLine2!=null && User.primaryAddressLine2!=''){
      return User.primaryAddressLine1+','+User.primaryAddressLine2+','+User.primaryAddressCity+','+User.primaryAddressState+','+User.pincode;
    }
    return User.primaryAddressLine1+','+User.primaryAddressCity+','+User.primaryAddressState+','+User.pincode;
  }
  @override
  Widget build(BuildContext context) {
    String groupVal='COD';
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
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
                      onPressed: (){
                        Navigator.pushNamed(context, '/my_account');
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
                    title: Text('+91-'+User.phone),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color:Colors.black,
                    ),
                    title: Text(getAddress()),
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          '₹',
                          style: TextStyle(
                            fontSize: 25
                          ),
                        ),
                        title: Text('Payment Mode'),
                      ),
                      ListTile(
                        leading: Radio(
                          groupValue: groupVal,
                          value: 'COD',
                          onChanged: (value){
                            groupVal='COD';
                          },
                        ),
                        title: Text('Cash on Delivery\n(UPI and wallets also available at delivery time)'),
                      ),
                      ListTile(
                        leading: Radio(
                          groupValue: groupVal,
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
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/order_confirm_buffer');
              },
              child: Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }
}