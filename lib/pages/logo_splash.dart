import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/Data.dart';
import 'package:laundro/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laundro/model/user_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _firestore = Firestore.instance;
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
        User.uid = prefs.getString('loggedInUserUserid');
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
        User.selectedShopId = prefs.getString('loggedInUserSelectedShopId');
        User.selectedShopName = prefs.getString('loggedInUserSelectedShopName');
        User.selectedShopNumber =
            prefs.getString('loggedInUserSelectedShopPhoneNumber');
        DocumentSnapshot ds = await _firestore
            .collection('priceList')
            .document(User.selectedShopId)
            .get();
        Database.ironingDataItems = ds.data['ironingPrices'];
        Database.washingDataItems = ds.data['washingPrices'];
        Database.dryCleaningDataItems = ds.data['dryCleaningPrices'];
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
                color: mainColor,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/app_logo/GimmeLogo.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
