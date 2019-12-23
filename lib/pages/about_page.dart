import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Material(
              color: Color(0xfff2f3f7),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        //borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis hendrerit dolor magna eget. Sed felis eget velit aliquet. A cras semper auctor neque vitae. A lacus vestibulum sed arcu.",
                        style: kparagraphTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Our Team',
                            style: kTitleTextStyle,
                            ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/team/abhishek.jpeg'),
                            radius: 75,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Our Team',
                            style: kTitleTextStyle,
                            ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
