import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';

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
          title: Text('Laundro'),
          centerTitle: true,
          backgroundColor: Color(0xFF73AEF5),
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
                                child: Container(
                                  height: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  //child:Image.asset('images/products/Design.png'),
                                  decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(40),
                                          image: DecorationImage(
                                                image: ExactAssetImage(
                                                  'images/products/Design.png')),),
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
                                  margin: EdgeInsets.all(10),
                                  //child: Text("hii"),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              'images/products/wash.png')),
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(40),
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
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              'images/products/Dry.png'),
                                              ),
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(40)),
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

/*new ListView(
        children: <Widget>[
          image_carousel,
          Container(
            color: Theme.of(context).backgroundColor,
            height: 400.0,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/iron'),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 170.0,
                        child: Image.asset('images/products/Design.png'),
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/wash'),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              height: 170.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: ExactAssetImage(
                                        'images/products/wash.png')),
                                color: Theme.of(context).buttonColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ))),
                  ],
                )),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/dry-clean'),
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                height: 170,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(
                                          'images/products/Dry.png')),
                                  color: Theme.of(context).buttonColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ))),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        height: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage(
                                  'images/products/tailoring.png')),
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
