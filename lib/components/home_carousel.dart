import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5,left: 5,right: 5),
      height: 3*(MediaQuery.of(context).size.height/10),
      width: 400,
      //image slideshow
      child: new Carousel(
        //borderRadius: true,
        //radius: Radius.circular(40),
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
        animationDuration: Duration(milliseconds: 2000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        dotColor: Colors.blueAccent,
        dotBgColor: Colors.transparent,
      ),
    );
  }
}
