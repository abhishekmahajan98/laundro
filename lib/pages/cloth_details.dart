import 'package:flutter/material.dart';

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
      ),
      body: ListView(
        children: clothList,
      ),
    );
  }
}