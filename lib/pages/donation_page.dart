import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Donate clothes',
            style: kCategoryTextStyle,
            ),
        ),
      ),
    );
  }
}