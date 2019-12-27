import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';


class YourOrdersPage extends StatefulWidget {
  @override
  _YourOrdersPageState createState() => _YourOrdersPageState();
}

class _YourOrdersPageState extends State<YourOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
        backgroundColor: Color(0XFF6bacde),
      ),
      body: Center(
        child: Text(
          'Yours Orders',
          style: kCategoryTextStyle,
        ),
      ),
    );
  }
}