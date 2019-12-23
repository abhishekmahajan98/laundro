import 'package:flutter/material.dart';

import '../constants.dart';

Widget teamMember({String imagePath,String name,String position,String workProfile=''}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      /*Padding(
        padding: const EdgeInsets.only(left: 90,right: 90),
        child: Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ),*/
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 60,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Text(
                  name,
                  style: kteamMemberName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0,0),
                child: Text(
                  position,
                  style: kBlackLabelTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0,0),
                child: Text(
                  workProfile,
                  style: kBlackLabelTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}