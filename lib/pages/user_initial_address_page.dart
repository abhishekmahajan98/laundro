import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAddressPage extends StatefulWidget {
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  SharedPreferences prefs;
  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget _buildAddressLine1() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            User.primaryAddressLine1 = value;
          });
        },
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Line 1',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildAddressLine2() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            User.primaryAddressLine2 = value;
          });
        },
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Line 2(optional)',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildCity() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            User.primaryAddressCity = value;
          });
        },
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'City',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildState() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            User.primaryAddressState = value;
          });
        },
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'State',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildPincode() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            User.pincode = value;
          });
        },
        style: TextStyle(
          color: User.pincode.length == 6 ? Colors.white : Colors.red,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Pincode',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _nextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
          onPressed: () {
            if (User.primaryAddressLine1.length > 1 &&
                User.primaryAddressCity.length > 1 &&
                User.primaryAddressState.length > 1 &&
                User.pincode.length == 6) {
              User.primaryAddress = User.primaryAddressLine1 +
                  '+' +
                  User.primaryAddressLine2 +
                  '+' +
                  User.primaryAddressCity +
                  '+' +
                  User.primaryAddressState +
                  '+' +
                  User.pincode;
              prefs.setString('loggedInUserDisplayName', User.displayName);
              prefs.setString('loggedInUserPhoneNumber', User.phone);
              prefs.setString('loggedInUserDOB', User.dob.toString());
              prefs.setString('loggedInUserGender', User.gender);
              prefs.setString(
                  'loggedInUserPrimaryAddressLine1', User.primaryAddressLine1);
              prefs.setString(
                  'loggedInUserPrimaryAddressLine2', User.primaryAddressLine2);
              prefs.setString(
                  'loggedInUserPrimaryAddressCity', User.primaryAddressCity);
              prefs.setString(
                  'loggedInUserPrimaryAddressState', User.primaryAddressState);
              prefs.setString(
                  'loggedInUserPrimaryAddressPincode', User.pincode);
              prefs.setString(
                  'loggedInUserPrimaryAddress', User.primaryAddress);
              _firestore.document('users/' + User.uid).setData({
                'email': User.email,
                'displayName': User.displayName,
                'phoneNumber': User.phone,
                'gender': User.gender,
                'dob': User.dob.toString(),
                'primaryAddress': User.primaryAddress,
                'primaryAddressLine1': User.primaryAddressLine1,
                'primaryAddressLine2': User.primaryAddressLine2,
                'primaryAddressCity': User.primaryAddressCity,
                'primaryAddressState': User.primaryAddressState,
                'primaryAddressPincode': User.pincode,
              });
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Alert(
                  context: context,
                  title: 'Please fill the form ',
                  desc:
                      'Please fill the name,10 digit phone number and the Date of birth',
                  buttons: [
                    DialogButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]).show();
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Extra Details',
                    style: TextStyle(
                      color: Colors.white,
                      //fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildAddressLine1(),
                  SizedBox(height: 30.0),
                  _buildAddressLine2(),
                  SizedBox(height: 30.0),
                  _buildCity(),
                  SizedBox(height: 30.0),
                  _buildState(),
                  SizedBox(height: 30.0),
                  _buildPincode(),
                  SizedBox(height: 30.0),
                  _nextButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
