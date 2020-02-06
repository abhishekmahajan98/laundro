import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';

final _firestore = Firestore.instance;

class ShopChangeBox extends StatelessWidget {
  ShopChangeBox(
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
        if (uid != User.selectedShopId) {
          User.selectedShopId = uid;
          User.selectedShopName = displayName;
          User.selectedShopNumber = phoneNumber;

          _firestore.collection('users').document(User.uid).updateData({
            'selectedShopId': User.selectedShopId,
            'selectedShopPhoneNumber': User.selectedShopNumber,
            'selectedShopName': User.selectedShopName,
          }).then((val) {
            Navigator.pop(context);
          });
        }
      },
      child: Card(
        child: Column(
          children: <Widget>[
            uid == User.selectedShopId
                ? Material(
                    color: Colors.green[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Current Selection',
                          style: TextStyle(
                            color: mainColor,
                            fontFamily: "OPen Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
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
