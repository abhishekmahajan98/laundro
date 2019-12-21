import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';

import '../components/side_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      margin: EdgeInsets.only(top:10),
      height: 200.0,
      width: 400,
      //image slideshow
      child: new Carousel(
        borderRadius: true,
        radius: Radius.circular(40),
        //overlayShadow: true,
        boxFit: BoxFit.cover,
        animationCurve: Curves.easeInOut,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/m2.jpg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: true,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        dotColor: Colors.pinkAccent,
        dotBgColor: Colors.transparent,
      ),
    );

    return SafeArea(
          child: Scaffold(
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
              Expanded(
                flex: 2,
                child: imageCarousel,
              ),
              Expanded(
                flex: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,

                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/iron'),
                                child: Container(
                                  height: double.infinity,
                                  margin: EdgeInsets.fromLTRB(10.0, 10, 2, 2),
                                  child: Image(
                                    image: AssetImage(
                                        'images/icons/ironing.png'
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/wash'),
                                child: Container(
                                  height: double.infinity,
                                    margin: EdgeInsets.fromLTRB(2, 10, 10, 2),
                                  child: Image(image: AssetImage(
                                      'images/icons/washing.png'
                                  ), ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/dry-clean'),
                                child: Container(
                                  height: double.infinity,
                                  margin: EdgeInsets.fromLTRB(10, 2, 2, 2),
                                  child: Image(image: AssetImage(
                                      'images/icons/dryclean.png'
                                  ), ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/iron'),
                                child: Container(
                                  height: double.infinity,
                                  margin: EdgeInsets.fromLTRB(2, 2, 10, 2),
                                  //child: Center(child: Text("hii")),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
