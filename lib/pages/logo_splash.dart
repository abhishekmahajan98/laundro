import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundro/model/user_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      instantiateSP();
    });
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    checkLoggedInStatus();
  }

  void checkLoggedInStatus() async {
    if (prefs.containsKey('loggedInUserEmail')) {
      try {
        User.email = prefs.getString('loggedInUserEmail');
        User.uid = prefs.getString('loggedInUserUid');
        User.phone = prefs.getString('loggedInUserPhoneNumber');
        User.displayName = prefs.getString('loggedInUserDisplayName');
        User.gender = prefs.getString('loggedInUserGender');
        User.dob = DateTime.parse(prefs.getString('loggedInUserDOB'));
        User.primaryAddress = prefs.getString('loggedInUserPrimaryAddress');
        User.placeName = prefs.getString('loggedInUserPlaceName');
        User.locality = prefs.getString('loggedInUserLocality');
        User.administrativeArea =
            prefs.getString('loggedInUserAdministrativeArea');
        User.landmark = prefs.getString('loggedInUserLandmark');
        User.pincode = prefs.getString('loggedInUserPincode');
        User.lattitude = prefs.getDouble('loggedInUserLattitude');
        User.longitude = prefs.getDouble('loggedInUserLongitude');
        Navigator.pushReplacementNamed(context, '/home');
        //Navigator.pushReplacementNamed(context, '/test_page');
      } catch (e) {
        print(e);
        prefs.clear();
        _auth.signOut();
        googleSignIn.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      prefs.clear();
      _auth.signOut();
      googleSignIn.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    }
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
                color: Color(0XFF6bacde),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/app_logo/LOGO1.png',
                        width: 300,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
