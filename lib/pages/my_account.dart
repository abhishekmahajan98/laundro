import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  String displayName = User.displayName, email = User.email;
  String updatedNumber = User.phone;
  String updatedAddressLine1 = User.primaryAddressLine1;
  String updatedAddressLine2 = User.primaryAddressLine2;
  String updatedCity = User.primaryAddressCity;
  String updatedState = User.primaryAddressState;
  String updatedPincode = User.pincode;
  String updatedPrimaryAddress = User.primaryAddress;

  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
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
            onPressed: (){
              updatedPrimaryAddress = updatedAddressLine1 +
                  "+" +
                  updatedAddressLine2 +
                  "+" +
                  updatedCity +
                  "+" +
                  updatedState +
                  "+" +
                  updatedPincode;
              if (updatedNumber != User.phone ||
                  updatedPincode != User.pincode ||
                  updatedPrimaryAddress != User.primaryAddress) {
                if (updatedPincode.length == 6 &&
                    updatedNumber.length == 10 &&
                    updatedAddressLine1.length >= 1 &&
                    updatedCity.length > 1 &&
                    updatedState.length > 1) {
                  User.primaryAddress = updatedPrimaryAddress;
                  User.phone = updatedNumber;
                  User.primaryAddressLine1 = updatedAddressLine1;
                  User.primaryAddressLine2 = updatedAddressLine2;
                  User.primaryAddressCity = updatedCity;
                  User.primaryAddressState = updatedState;
                  User.pincode = updatedPincode;
                  //remove previous prefs
                  prefs.remove('loggedInUserPhoneNumber');
                  prefs.remove('loggedInUserPrimaryAddress');
                  prefs.remove('loggedInUserPrimaryAddressLine1');
                  prefs.remove('loggedInUserPrimaryAddressLine2');
                  prefs.remove('loggedInUserPrimaryAddressCity');
                  prefs.remove('loggedInUserPrimaryAddressState');
                  prefs.remove('loggedInUserPrimaryAddressPincode');
                  //set updated prefs
                  prefs.setString('loggedInUserPhoneNumber', User.phone);
                  prefs.setString('loggedInUserPrimaryAddressLine1',
                      User.primaryAddressLine1);
                  prefs.setString('loggedInUserPrimaryAddressLine2',
                      User.primaryAddressLine2);
                  prefs.setString('loggedInUserPrimaryAddressCity',
                      User.primaryAddressCity);
                  prefs.setString('loggedInUserPrimaryAddressState',
                      User.primaryAddressState);
                  prefs.setString(
                      'loggedInUserPrimaryAddressPincode', User.pincode);
                  prefs.setString(
                      'loggedInUserPrimaryAddress', User.primaryAddress);
                  _firestore
                      .collection('users')
                      .document(User.uid)
                      .updateData({
                    'phoneNumber': User.phone,
                    'primaryAddress': User.primaryAddress,
                    'primaryAddressLine1': User.primaryAddressLine1,
                    'primaryAddressLine2': User.primaryAddressLine2,
                    'primaryAddressCity': User.primaryAddressCity,
                    'primaryAddressState': User.primaryAddressState,
                    'primaryAddressPincode': User.pincode,
                  });
                  Navigator.pop(context);
                }
                else{
                  Alert(
                      context: context,
                      title: 'Invalid data in Fields',
                      desc:
                      'Please check the fields entered.',
                      buttons: [
                        DialogButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]).show();
                }
              }
              else{
                Navigator.pop(context);
              }
            },
            child: Text(
                'Save',
              style: kCategoryTextStyle,
            ),
          ),
        ),
        appBar: AppBar(
          title: Text("My Account"),
          centerTitle: true,

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
                                initialValue: updatedAddressLine1,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    updatedAddressLine1 = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("Line 2      "),
                              title: TextFormField(
                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                initialValue: updatedAddressLine2,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    updatedAddressLine2 = value;
                                  });
                                },

                              ),
                            ),
                            ListTile(
                              leading: Text("City         "),
                              title: TextFormField(
                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.text,
                                initialValue: updatedCity,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
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
                                initialValue: updatedState,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
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
                                initialValue: updatedPincode,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: updatedPincode.length == 6
                                      ? Colors.black
                                      : Colors.red,
                                ),
                                enabled: editPrimaryAddress,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  setState(() {
                                    updatedPincode = value;
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
