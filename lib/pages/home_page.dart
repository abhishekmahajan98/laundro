import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/pages/welcome.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void initState() {
    super.initState();
  }

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
            onPressed: () {},
          ),
        ],
      ),
      //app drawer
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header
            new UserAccountsDrawerHeader(
              accountName: Text('Abhishek Mahajan'),
              accountEmail: Text('abhishekmah98@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            //body
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/'),
              child: ListTile(
                title: Text('Home'),
                leading: Icon(
                  Icons.home,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/myaccount'),
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(
                  Icons.person,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Previous Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.pinkAccent,
                ),
              ),
            ),

            Divider(
              color: Colors.teal,
              height: 5,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/about'),
              child: ListTile(
                title: Text('About us'),
                leading: Icon(
                  Icons.help,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Contact us'),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _auth.signOut();
                googleSignIn.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
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
}
