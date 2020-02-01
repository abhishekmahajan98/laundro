import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  final timeNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.height * (2 / 5),
              width: MediaQuery.of(context).size.width,
              color: mainColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'GIMME',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height / 40),
                          ),
                          FloatingActionButton(
                            backgroundColor: blurredMainColor,
                            onPressed: () {
                              Navigator.pushNamed(context, '/otp_page');
                            },
                            child: Text(
                              'OTP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            timeNow.hour < 12
                                ? 'Good Morning,'
                                : timeNow.hour < 16
                                    ? 'Good Afternoon'
                                    : 'Good Evening',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 20),
                          child: RotateAnimatedTextKit(
                              displayFullTextOnTap: true,
                              totalRepeatCount: 40,
                              transitionHeight:
                                  MediaQuery.of(context).size.height / 15,
                              isRepeatingAnimation: true,
                              text: [
                                "How may we service you today?",
                                "Have some dirty clothes?",
                                "How's your day going?",
                                "Trust us to make your laundry easier.",
                              ],
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height / 35,
                                fontFamily: "Horizon",
                              ),
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional
                                  .topStart // or Alignment.topLeft

                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Card(
                    color: blurredMainColor,
                    elevation: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/iron');
                      },
                      child: ListTile(
                        //isThreeLine: true,
                        leading: Container(
                            margin: EdgeInsets.all(10),
                            child: Icon(Icons.all_inclusive)),
                        subtitle: Text('Starting at ₹7'),
                        title: Text(
                          'Ironing',
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Card(
                    color: blurredMainColor,
                    elevation: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/wash');
                      },
                      child: ListTile(
                        //isThreeLine: true,
                        leading: Container(
                            margin: EdgeInsets.all(10),
                            child: Icon(Icons.all_inclusive)),
                        subtitle: Text('Starting at ₹7'),
                        title: Text(
                          'Washing',
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Card(
                    color: blurredMainColor,
                    elevation: 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/dry-clean');
                      },
                      child: ListTile(
                        //isThreeLine: true,
                        leading: Container(
                            margin: EdgeInsets.all(10),
                            child: Icon(Icons.all_inclusive)),
                        subtitle: Text('Starting at ₹7'),
                        title: Text(
                          'Dry Cleaning',
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 35,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
