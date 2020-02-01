import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';

class ClothDetails extends StatelessWidget {
  ClothDetails({
    Key key,
    @required this.clothList,
  });
  final clothList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundro'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: clothList,
      ),
    );
  }
}
