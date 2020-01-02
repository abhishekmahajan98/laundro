import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/components/home_carousel.dart';
import 'package:laundro/components/square_button.dart';
import 'package:laundro/constants.dart';
import '../components/side_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          elevation: 0.1,
          title: Hero(
            tag: 'logo',
            child: Image.asset(
              'images/app_logo/LOGO1.png',
              width: 200,
              )
          ),
          centerTitle: true,
          backgroundColor: Color(0XFF6bacde),
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
            ),
          ],
        ),
        //app drawer
        drawer: SideDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
            color: Color(0xfff2f3f7),
          child: Column(
            children: <Widget>[
              //carousel expanded
              Expanded(
                flex: 2,
                //from components/home_carousel
                child: ImageCarousel(),
              ),
              //rest of buttons
              Expanded(
                flex: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
                            SquareButton(
                              marginL: 10,
                              marginT: 10,
                              marginR: 2,
                              marginB: 2,
                              imageRoute:'images/icons/ironing.png',
                              buttonTag: 'Ironing',
                              ontap: () => Navigator.pushNamed(context, '/iron'),
                              //Navigator.pushNamed(context, '/iron'),
                            ),
                            SquareButton(
                              marginL: 2,
                              marginT: 10,
                              marginR: 10,
                              marginB: 2,
                              imageRoute:'images/icons/washing.png',
                              buttonTag: 'Washing',
                              ontap: () => Navigator.pushNamed(context, '/wash'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
                            SquareButton(
                              marginL: 10,
                              marginT: 2,
                              marginR: 2,
                              marginB: 2,
                              imageRoute:'images/icons/dryclean.png',
                              buttonTag: 'Dry Cleaning',
                              ontap: () => Navigator.pushNamed(context, '/dry-clean'),
                            ),
                            SquareButton(
                              marginL: 2,
                              marginT: 2,
                              marginR: 10,
                              marginB: 2,
                              imageRoute:'images/cloth_donate.png',
                              buttonTag: 'Donate Clothes',
                              ontap: () => Navigator.pushNamed(context, '/donate_page'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/new_features');
                          },
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(
                                FontAwesomeIcons.voteYea,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Vote for our next Feature!!',
                                style: kCategoryTextStyle,
                                ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
