import 'package:flutter/material.dart';
class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Details'),
        backgroundColor: Colors.blue,
      ),
      body:
      Column(
        children: <Widget>[

          new UserAccountsDrawerHeader(

            accountName: Text('Sourabh pisipati'),
            accountEmail:Text('sourabhpisipati0@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            height: 70.0,
            width: 600.0,
            child: Center(child: Text("Phone Number :   9999999999",style: TextStyle(color:Colors.white,fontSize: 20.0),)),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            height: 90.0,
            width: 600.0,
            child: Center(child: Text(
              '''Address :Z-405 Abode valley
                Potheri,603203''',
              style: TextStyle(
                  color:Colors.white,
                  fontSize: 20.0),
            )
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),

        ],
      ),

    );
  }
}
