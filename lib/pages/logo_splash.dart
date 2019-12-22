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
  /*@override
  void initState() {
    Timer(
      Duration(seconds: 1),
      (){
        Navigator.pushNamed(context, '/login');
        }
    );
    super.initState();
  }*/
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
        User.primaryAddressLine1 =
            prefs.getString('loggedInUserPrimaryAddressLine1');
        User.primaryAddressLine2 =
            prefs.getString('loggedInUserPrimaryAddressLine2');
        User.primaryAddressCity =
            prefs.getString('loggedInUserPrimaryAddressCity');
        User.primaryAddressState =
            prefs.getString('loggedInUserPrimaryAddressState');
        User.pincode = prefs.getString('loggedInUserPrimaryAddressPincode');
        Navigator.pushReplacementNamed(context, '/home');
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'images/app_logo/LOGO1.png',
                      width: 400,
                    )
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
