import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';


class PreviousOrdersPage extends StatefulWidget {
  @override
  _PreviousOrdersPageState createState() => _PreviousOrdersPageState();
}

class _PreviousOrdersPageState extends State<PreviousOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Text(
              'Previous Orders',
              style: kCategoryTextStyle,
            ),
          ),
    );
  }
}