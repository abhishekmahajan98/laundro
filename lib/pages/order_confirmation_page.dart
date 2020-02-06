import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/screen_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:laundro/model/user_model.dart';

final _firestore = Firestore.instance;

class OrderConfirmationPage extends StatefulWidget {
  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  double orderRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Order Placed Successfully',
            style: TextStyle(
              color: mainColor,
              fontSize: MediaQuery.of(context).size.height / 35,
            ),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FlareActor(
                "images/flare/SuccessCheck.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "Untitled",
              ),
            ),
          ),
          Text(
            "Please Rate You Experience",
            style: TextStyle(
              color: mainColor,
              fontSize: MediaQuery.of(context).size.height / 35,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          RatingBar(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                orderRating = rating;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: mainColor,
                onPressed: () {
                  if (orderRating > 0) {
                    _firestore.collection('user ratings').document().setData({
                      'rating': orderRating.toString(),
                      'timestamp': DateTime.now(),
                      'uid': User.uid,
                    });
                  }
                  Navigator.pop(context);
                  HomeIdx.selectedIndex = 0;
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
