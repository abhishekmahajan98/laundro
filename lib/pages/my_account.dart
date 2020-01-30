import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

//TODO UPDATE USER DATA IN MY ACCOUNT PAGE
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
  //String updatedAddressLine1 = User.primaryAddressLine1;
  //String updatedAddressLine2 = User.primaryAddressLine2;
  //String updatedCity = User.primaryAddressCity;
  //String updatedState = User.primaryAddressState;
  //String updatedPincode = User.pincode;
  //String updatedPrimaryAddress = User.primaryAddress;

  //final _firestore = Firestore.instance;

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
        resizeToAvoidBottomPadding: false,
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            color: Color(0XFF6bacde),
            onPressed: () {
              /*
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
              }*/
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
          backgroundColor: Color(0XFF6bacde),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0XFF6bacde),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xfff2f3f7),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                            enabled: false,
                            initialValue: User.email,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
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
                                color: Colors.black,
                              ),
                              title: Text(
                                'Primary Address',
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/address_update_page');
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
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
