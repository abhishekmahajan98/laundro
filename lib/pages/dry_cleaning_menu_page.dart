import 'package:flutter/material.dart';
import 'package:laundro/Data.dart';
import 'package:laundro/components/drycleaning_page_tile.dart';

class DryCleaningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('Dry Cleaning page'),
        centerTitle: true,
        backgroundColor: Color(0XFF6bacde),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: Database.dryCleaningDataItems.length,
              itemBuilder: (BuildContext ctxt, int index){
                return DryCleaningTile(
                  index:index,
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: RaisedButton(
              color: Colors.red,
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/cart');
              },
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
