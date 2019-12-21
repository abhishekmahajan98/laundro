import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  SharedPreferences prefs;
  bool editPhoneNumber = false;
  bool editPrimaryAddress = false;
  bool editSecondaryAddress = false;
  String displayName = 'null', email = 'null';
  String updatedNumber = User.phone;
  String updatedLine1='';
  String updatedLine2='';
  String updatedCity;
  String updatedState;
  String pincode=User.pincode;
  String primaryAddress=User.address;



  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    print(User.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            color: Colors.blue,
            onPressed: (){},
            child: Text(
                'Save',
              style: kCategoryTextStyle,
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("My Account"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              highlightColor: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (updatedNumber.length == 10 && updatedNumber != User.phone) {
                  User.phone = updatedNumber;
                  prefs.remove('loggedInUserPhoneNumber');
                  prefs.setString('loggedInUserPhoneNumber', User.phone);
                  _firestore.collection('users').document(User.uid).updateData({
                    'phoneNumber': User.phone,
                  });

                  Navigator.pop(context);
                }
                if (updatedLine1.length >=1 && pincode.length==6 ) {
                  primaryAddress =
                      updatedLine1 + "\\" + updatedLine2 + "\\" + updatedCity +
                          "\\" + updatedState + "\\" + pincode;
                  User.address = primaryAddress;
                  _firestore.collection('users').document(User.uid).updateData({
                    'Address': User.address,

                  });
                  User.pincode = pincode;
                  _firestore.collection('users').document(User.uid).updateData({
                    'pincode': User.pincode,
                  });
                  Navigator.pop(context);
                }

              },
            )
          ],
          backgroundColor: Color(0xFF73AEF5),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),

                    Text(
                      User.displayName == null ? '' : User.displayName,
                      style: TextStyle(
                        fontSize: 30,

                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(
                          0xfff2f3f7
                      ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10,5),
                        decoration: BoxDecoration(color: Colors.white,),
                        child: ListTile(
                          title: TextFormField(
                            enabled: editPhoneNumber,
                            keyboardType: TextInputType.phone,
                            initialValue: User.phone,
                            style: TextStyle(
                              fontSize: 20,
                              color: updatedNumber.length == 10
                                  ? Colors.black
                                  : Colors.red,
                            ),
                            onChanged: (value) {
                              setState(() {
                                updatedNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              prefixText: '+91-',
                              //hintText: 'Enter your Email',
                              //hintStyle: kHintTextStyle,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                editPhoneNumber = !editPhoneNumber;
                              });
                            },
                            child: Icon(
                              editPhoneNumber == false
                                  ? Icons.edit
                                  : Icons.check,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.home,
                              ),
                              title: Text(
                                'Primary Address',
                                style: TextStyle(
                                    fontSize: 18),
                              ),
                              trailing: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    editPrimaryAddress=!editPrimaryAddress;
                                  });
                                },
                                child: Icon(
                                  editPrimaryAddress == false
                                      ? Icons.edit
                                      : Icons.check,
                                  color: Colors.black,
                                ),
                              ),

                            ),
                            ListTile(
                              leading: Text("Line 1      "),
                              title: TextFormField(
                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    updatedLine1 = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("Line 2      "),
                              title: TextFormField(

                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    updatedLine2 = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("City         "),
                              title: TextFormField(

                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    updatedCity = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("State       "),
                              title: TextFormField(

                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    updatedState = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("Pincode  "),
                              title: TextFormField(
                                initialValue: pincode,
                                style: TextStyle(
                                  color: pincode.length == 6
                                      ? Colors.black
                                      : Colors.red,
                                ),
                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  setState(() {
                                    pincode = value;
                                  });
                                },

                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),


                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
