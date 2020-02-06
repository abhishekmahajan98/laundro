import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/components/shop_change_box.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = Firestore.instance;

class ShopChangePage extends StatefulWidget {
  @override
  _ShopChangePageState createState() => _ShopChangePageState();
}

class _ShopChangePageState extends State<ShopChangePage> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  bool showSpinner = true;
  List<ShopChangeBox> shopsList = [];

  @override
  void initState() {
    super.initState();
    getShopsInRange().then((val) {
      setState(() {
        showSpinner = false;
      });
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    //print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }

  Future<bool> getShopsInRange() async {
    try {
      QuerySnapshot shops = await _firestore.collection('shop').getDocuments();
      for (var shop in shops.documents) {
        GeoPoint shopLoc = shop.data['geoLocation'];
        //print(User.lattitude.toString() + " " + User.longitude.toString());
        //print(shopLoc.latitude.toString() + " " + shopLoc.longitude.toString());
        double dist = calculateDistance(User.lattitude, User.longitude,
            shopLoc.latitude, shopLoc.longitude);
        if (dist <= 2) {
          final uid = shop.data['uid'];
          final phoneNumber = shop.data['phoneNumber'];
          final primaryAddress = shop.data['primaryAddress'];
          final landmark = shop.data['landmark'];
          final desc = shop.data['desc'];
          final displayName = shop.data['displayName'];
          setState(() {
            shopsList.add(ShopChangeBox(
              uid: uid,
              phoneNumber: phoneNumber,
              primaryAddress: primaryAddress,
              landmark: landmark,
              desc: desc,
              displayName: displayName,
            ));
          });
        }
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showSpinner == true
          ? null
          : shopsList.length > 0
              ? null
              : RaisedButton(
                  color: mainColor,
                  onPressed: () async {
                    prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    _auth.signOut();
                    googleSignIn.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login", (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Log-out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height / 40,
                      ),
                    ),
                  ),
                ),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Change Shop'),
        centerTitle: true,
      ),
      body: showSpinner == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: mainColor,
              ),
            )
          : Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Please Select one of the Shops from below.',
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  subtitle: Text(
                      'Hint: Don\'t worry, you can change the shop later too!'),
                ),
                Flexible(
                  child: ListView(
                    children: shopsList.length > 0
                        ? shopsList
                        : <Widget>[
                            Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      'Sorry, We have no shops near You!',
                                      style: TextStyle(
                                        color: mainColor,
                                        fontFamily: "Open Sans",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                  ),
                ),
              ],
            ),
    );
  }
}
