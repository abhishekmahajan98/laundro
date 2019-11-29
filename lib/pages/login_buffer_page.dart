import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BufferPage extends StatefulWidget {
  @override
  _BufferPageState createState() => _BufferPageState();
}

class _BufferPageState extends State<BufferPage> {
  final _firestore=Firestore.instance;
  SharedPreferences prefs;
  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 1),
      (){
        instantiateSP();
        retrieveUserData();
        } 
    );
  }
  void instantiateSP() async{
    prefs = await SharedPreferences.getInstance();
  }
  void retrieveUserData() async{
    final document=await _firestore.collection('users').document(User.uid).get();
    if(document.data['displayName']!=null && document.data['phoneNumber']!=null){
      User.displayName=document.data['displayName'];
      User.dob=DateTime.parse(document.data['dob']);
      User.phone=document.data['phoneNumber'];
      User.gender=document.data['gender'];
      prefs.setString('loggedInUserDisplayName', User.displayName);
      prefs.setString('loggedInUserPhoneNumber', User.phone);
      prefs.setString('loggedInUserDOB', User.dob.toString());
      prefs.setString('loggedInUserGender', User.gender);
      navigateToHome();
    }
    else{  
      navigateToDetails();
    }


  }
  void navigateToHome(){
    Navigator.pushReplacementNamed(context, '/home');
  }
  void navigateToDetails(){
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