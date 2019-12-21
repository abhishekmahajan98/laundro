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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Image(
                                        image: AssetImage('images/icons/ironing.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:Text(
                                        'Ironing',
                                        style: kCategoryTextStyle,
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/wash'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Image(
                                        image: AssetImage('images/icons/washing.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:Text(
                                        'Washing',
                                        style: kCategoryTextStyle,
                                        ),
                                    )
                                    
                                  ],
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Image(
                                        image: AssetImage('images/icons/dryclean.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:Text(
                                        'Dry-Cleaning',
                                        style: kCategoryTextStyle,
                                        ),
                                    )
                                    
                                  ],
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
                                  margin: EdgeInsets.all(10),
                                  //child: Center(child: Text("hii")),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(40),
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
