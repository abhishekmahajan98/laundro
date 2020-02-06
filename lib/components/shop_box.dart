import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopBox extends StatelessWidget {
  ShopBox(
      {@required this.uid,
      @required this.primaryAddress,
      @required this.landmark,
      @required this.desc,
      @required this.displayName,
      @required this.phoneNumber});
  final String uid;
  final String primaryAddress;
  final String landmark;
  final String desc;
  final String displayName;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        try {
          User.selectedShopId = uid;
          User.selectedShopName = displayName;
          User.selectedShopNumber = phoneNumber;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final _firestore = Firestore.instance;
          prefs.setString('loggedInUserDisplayName', User.displayName);
          prefs.setString('loggedInUserPhoneNumber', User.phone);
          prefs.setString('loggedInUserDOB', User.dob.toString());
          prefs.setString('loggedInUserGender', User.gender);
          prefs.setString('loggedInUserPlaceName', User.placeName);
          prefs.setString('loggedInUserLocality', User.locality);
          prefs.setString('loggedInUserPincode', User.pincode);
          prefs.setString(
              'loggedInUserAdminstrativeArea', User.administrativeArea);
          prefs.setString('loggedInUserPrimaryAddress', User.primaryAddress);
          prefs.setString('loggedInUserLandmark', User.landmark);
          prefs.setDouble('loggedInUserLattitude', User.lattitude);
          prefs.setDouble('loggedInUserLongitude', User.longitude);
          prefs.setString('loggedInUserSelectedShopId', User.selectedShopId);
          prefs.setString(
              'loggedInUserSelectedShopPhoneNumber', User.selectedShopNumber);
          prefs.setString(
              'loggedInUserSelectedShopName', User.selectedShopName);
          _firestore.document('users/' + User.uid).setData({
            'uid': User.uid,
            'email': User.email,
            'displayName': User.displayName,
            'phoneNumber': User.phone,
            'gender': User.gender,
            'dob': User.dob.toString(),
            'placeName': User.placeName,
            'locality': User.locality,
            'administrativeArea': User.administrativeArea,
            'pincode': User.pincode,
            'primaryAddress': User.primaryAddress,
            'landmark': User.landmark,
            'geoLocation': GeoPoint(User.lattitude, User.longitude),
            'selectedShopId': User.selectedShopId,
            'selectedShopPhoneNumber': User.selectedShopNumber,
            'selectedShopName': User.selectedShopName,
            //'allocatedShopId': User.allocatedShopid,
            //'allocatedShopPhoneNumber': User.allocatedShopNumber,
          }).then((val) {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } catch (e) {
          Alert(
              context: context,
              title: 'Cant update information.',
              desc: 'Please close the application and try again in some time.',
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]).show();
        }
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              isThreeLine: true,
              leading: Icon(
                FontAwesomeIcons.info,
                color: mainColor,
              ),
              title: Text(
                displayName,
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                desc,
                style: TextStyle(
                  fontFamily: "Open Sans",
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.home,
                color: mainColor,
              ),
              title: Text(primaryAddress + ',landmark:' + landmark),
            )
          ],
        ),
      ),
    );
  }
}
