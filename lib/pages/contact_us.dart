import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _firestore = Firestore.instance;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Contact us'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.3, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'queries',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Enter your queries",
                        hintStyle: TextStyle(color: Colors.white30),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(new Radius.circular(25.0))),
                        labelStyle: TextStyle(color: Colors.white)),
                    maxLines: 8,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        message = value;
                      });
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 250.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      print(message);
                      _firestore.collection('queries').add({
                        'message': message,
                      });
                    },
                    color: Colors.blue,
                    child: Text(
                      "Send ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                    "9422222222",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text(
                    "laundro@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
