import 'dart:async';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/screen_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BufferPage extends StatefulWidget {
  @override
  _BufferPageState createState() => _BufferPageState();
}

class _BufferPageState extends State<BufferPage> {
  final _firestore = Firestore.instance;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      instantiateSP();
      retrieveUserData();
    });
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  void retrieveUserData() async {
    final document =
        await _firestore.collection('users').document(User.uid).get();
    if (document.data['displayName'] != null &&
        document.data['phoneNumber'] != null &&
        document.data['primaryAddress'] != null) {
      User.displayName = document.data['displayName'];
      User.uid = document.data['uid'];
      User.dob = DateTime.parse(document.data['dob']);
      User.phone = document.data['phoneNumber'];
      User.gender = document.data['gender'];
      User.primaryAddress = document.data['primaryAddress'];
      User.pincode = document.data['pincode'];
      User.landmark = document.data['landmark'];
      User.locality = document.data['locality'];
      User.placeName = document.data['placeName'];
      User.administrativeArea = document.data['administrativeArea'];
      GeoPoint p = document.data['geoLocation'];
      User.lattitude = p.latitude;
      User.longitude = p.longitude;

      prefs.setString('loggedInUserDisplayName', User.displayName);
      prefs.setString('loggedInUserPhoneNumber', User.phone);
      prefs.setString('loggedInUserDOB', User.dob.toString());
      prefs.setString('loggedInUserGender', User.gender);
      prefs.setString('loggedInUserPlaceName', User.placeName);
      prefs.setString('loggedInUserLocality', User.locality);
      prefs.setString('loggedInUserPincode', User.pincode);
      prefs.setString(
          'loggedInUserAdministrativeArea', User.administrativeArea);
      prefs.setString('loggedInUserPrimaryAddress', User.primaryAddress);
      prefs.setString('loggedInUserLandmark', User.landmark);
      prefs.setDouble('loggedInUserLattitude', User.lattitude);
      prefs.setDouble('loggedInUserLongitude', User.longitude);
      HomeIdx.selectedIndex = 0;
      navigateToHome();
    } else {
      navigateToDetails();
    }
  }

  void navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void navigateToDetails() {
    Navigator.pushReplacementNamed(context, '/extradetails');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'GIMME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
