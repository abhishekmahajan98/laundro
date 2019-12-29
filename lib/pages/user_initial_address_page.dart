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
  User user;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    user = await User.getPrefUser();
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
            user.primaryAddressLine1 = value;
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
            user.primaryAddressLine2 = value;
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
            user.primaryAddressCity = value;
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
            user.primaryAddressState = value;
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
            user.primaryAddressPincode = value;
          });
        },
        style: TextStyle(
          color: user.primaryAddressPincode.length == 6
              ? Colors.white
              : Colors.red,
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
          onPressed: () async {
            if (user.primaryAddressLine1.length > 1 &&
                user.primaryAddressCity.length > 1 &&
                user.primaryAddressState.length > 1 &&
                user.primaryAddressPincode.length == 6) {
              user.primaryAddress = user.primaryAddressLine1 +
                  '+' +
                  user.primaryAddressLine2 +
                  '+' +
                  user.primaryAddressCity +
                  '+' +
                  user.primaryAddressState +
                  '+' +
                  user.primaryAddressPincode;
              await user.setPrefUser();
              await Firestore.instance
                  .collection("users")
                  .document(user.uid)
                  .setData({
                'email': user.email,
                'uid': user.uid,
                'displayName': user.displayName,
                'phoneNumber': user.phoneNumber,
                'gender': user.gender,
                'dob': user.dob.toString(),
                'primaryAddress': user.primaryAddress,
                'primaryAddressLine1': user.primaryAddressLine1,
                'primaryAddressLine2': user.primaryAddressLine2,
                'primaryAddressCity': user.primaryAddressCity,
                'primaryAddressState': user.primaryAddressState,
                'primaryAddressPincode': user.primaryAddressPincode,
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
