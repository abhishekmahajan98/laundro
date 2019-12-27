import 'package:flutter/material.dart';
import 'package:laundro/components/home_carousel.dart';
import 'package:laundro/components/side_drawer.dart';
import 'package:laundro/components/square_button.dart';
import '../constants.dart';

class FirestoreTest extends StatefulWidget {
  @override
  _FirestoreTestState createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  double screenHeight,screenWidth;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          centerTitle: true,
          backgroundColor: Color(0XFF6bacde),
          title: Hero(
            tag: 'logo',
            child: Image.asset(
              'images/app_logo/LOGO1.png',
              width: 200,
              )
          ),
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
        drawer: SideDrawer(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xfff2f3f7),
          ),
          child: ListView(
            children: <Widget>[
              ImageCarousel(),
              Row(),
            ],
          ),
        ),
      );
  }
}