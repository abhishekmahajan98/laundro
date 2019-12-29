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
  User user;
  bool editPhoneNumber = false;
  bool editPrimaryAddress = false;
  bool editSecondaryAddress = false;
  String displayName;
  String email;
  String updatedNumber;
  String updatedAddressLine1;
  String updatedAddressLine2;
  String updatedCity;
  String updatedState;
  String updatedPincode;
  String updatedPrimaryAddress;
  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    user = await User.getPrefUser();
    displayName = user.displayName;
    email = user.email;
    updatedNumber = user.phoneNumber;
    updatedAddressLine1 = user.primaryAddressLine1;
    updatedAddressLine2 = user.primaryAddressLine2;
    updatedCity = user.primaryAddressCity;
    updatedState = user.primaryAddressState;
    updatedPincode = user.primaryAddressPincode;
    updatedPrimaryAddress = user.primaryAddress;
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
            onPressed: () async {
              updatedPrimaryAddress = updatedAddressLine1 +
                  "+" +
                  updatedAddressLine2 +
                  "+" +
                  updatedCity +
                  "+" +
                  updatedState +
                  "+" +
                  updatedPincode;
              if (updatedNumber != user.phoneNumber ||
                  updatedPincode != user.primaryAddressPincode ||
                  updatedPrimaryAddress != user.primaryAddress) {
                if (updatedPincode.length == 6 &&
                    updatedNumber.length == 10 &&
                    updatedAddressLine1.length >= 1 &&
                    updatedCity.length > 1 &&
                    updatedState.length > 1) {
                  user.primaryAddress = updatedPrimaryAddress;
                  user.phoneNumber = updatedNumber;
                  user.primaryAddressLine1 = updatedAddressLine1;
                  user.primaryAddressLine2 = updatedAddressLine2;
                  user.primaryAddressCity = updatedCity;
                  user.primaryAddressState = updatedState;
                  user.primaryAddressPincode = updatedPincode;
                  await user.setPrefUser();
                  await _firestore
                      .collection('users')
                      .document(user.uid)
                      .updateData({
                    'phoneNumber': user.phoneNumber,
                    'primaryAddress': user.primaryAddress,
                    'primaryAddressLine1': user.primaryAddressLine1,
                    'primaryAddressLine2': user.primaryAddressLine2,
                    'primaryAddressCity': user.primaryAddressCity,
                    'primaryAddressState': user.primaryAddressState,
                    'primaryAddressPincode': user.primaryAddressPincode,
                  });
                  Navigator.pop(context);
                } else {
                  Alert(
                      context: context,
                      title: 'Invalid data in Fields',
                      desc: 'Please check the fields entered.',
                      buttons: [
                        DialogButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]).show();
                }
              } else {
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
                      user.displayName == null ? '' : user.displayName,
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
                    color: Color(0xfff2f3f7),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: TextFormField(
                            enabled: editPhoneNumber,
                            keyboardType: TextInputType.phone,
                            initialValue: user.phoneNumber,
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
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editPrimaryAddress = !editPrimaryAddress;
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
                )),
          ],
        ),
      ),
    );
  }
}
