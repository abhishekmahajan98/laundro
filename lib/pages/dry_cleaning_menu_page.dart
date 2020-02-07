import 'package:flutter/material.dart';
import 'package:laundro/Data.dart';
import 'package:laundro/components/drycleaning_page_tile.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/screen_model.dart';

class DryCleaningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('Dry Cleaning page'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Database.dryCleaningDataItems.length > 0
                ? ListView.builder(
                    itemCount: Database.dryCleaningDataItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return DryCleaningTile(
                        index: index,
                      );
                    },
                  )
                : Center(
                    child: Text("No items"),
                  ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
                HomeIdx.selectedIndex = 1;
              },
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
