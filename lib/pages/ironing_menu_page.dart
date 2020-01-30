import 'package:flutter/material.dart';
import 'package:laundro/components/ironing_page_tile.dart';
import '../Data.dart';

class IroningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('Ironing page'),
        centerTitle: true,
        backgroundColor: Color(0XFF6bacde),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: Database.ironingDataItems.length,
              itemBuilder: (BuildContext ctxt, int index){
                return IroningTile(
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
