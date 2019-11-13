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
    Widget image_carousel = new Container(
      height: 200.0,
      //image slideshow
      child: new Carousel(
        boxFit: BoxFit.cover,
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text('Laundro'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: image_carousel,
            ),
            Expanded(
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
                                child:
                                    Image.asset('images/products/Design.png'),
                                decoration: BoxDecoration(color: Colors.red),
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
                                child: Text("hii"),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'images/products/wash.png')),
                                    color: Colors.blue),
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'images/products/Dry.png')),
                                    color: Colors.green),
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
                                child: Center(child: Text("hii")),
                                decoration: BoxDecoration(color: Colors.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                flex: 3),
          ],
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
