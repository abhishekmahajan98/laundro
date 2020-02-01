import 'package:flutter/material.dart';
import 'package:laundro/components/team_member_widget.dart';
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
        backgroundColor: mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0XFF6bacde),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/app_logo/LOGO1.png',
                    height: 100,
                    width: 400,
                  ),
                ],
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
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
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
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Our Team',
                            style: kTitleTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        teamMember(
                            imagePath: 'images/team/abhishek.jpeg',
                            name: 'Abhishek Mahajan',
                            position: 'Director'),
                        teamMember(
                            imagePath: 'images/team/sourabh.jpeg',
                            name: 'Sourabh Pisipati',
                            position: 'Director'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        'You can reach us at:',
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.web,
                            size: 40,
                            color: Colors.black,
                          ),
                          title: Text(
                            'laundroindia.com',
                            style: kBlackLabelTextStyle,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.black,
                          ),
                          title: Text(
                            '5th floor,Basic Engineering Laboratory,SRM University,Chennai-603203',
                            style: kBlackLabelTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
