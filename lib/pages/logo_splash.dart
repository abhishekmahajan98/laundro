import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 1),
      (){
        instantiateSP();
        
        } 
    );
  }
  void instantiateSP() async{
    prefs = await SharedPreferences.getInstance();
    checkLoggedInStatus();
    
  }

  void checkLoggedInStatus(){
    if(prefs.containsKey('loggedInUserEmail')){
      Navigator.pushReplacementNamed(context, '/home');
    }
    else{
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
                    child: Icon(
                      Icons.local_laundry_service,
                      size: 80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: Text(
                      'Laundro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
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