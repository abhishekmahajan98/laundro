import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
                child: AutoSizeText(
                  name,
                  minFontSize: 18,
                  maxFontSize: 25,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0,0),
                child: AutoSizeText(
                  position,
                  minFontSize: 12,
                  maxFontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0,0),
                child: AutoSizeText(
                  workProfile,
                  minFontSize: 12,
                  maxFontSize: 20,
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