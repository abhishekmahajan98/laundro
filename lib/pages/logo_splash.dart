import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/model/items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void initState() {
    super.initState();
    if (mounted) checkLoggedInStatus();
  }

  void checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      try {
        if (prefs.containsKey("iron") &&
            prefs.containsKey("wash") &&
            prefs.containsKey("dryclean"))
          await Items.getAndSetItemsFromFirebase();
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
