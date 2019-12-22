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
      body:Center(
        child: Text(
          'About Page',
          style: kCategoryTextStyle,
          ),
      ),
    );
  }
}
