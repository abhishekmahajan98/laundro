import 'package:flutter/material.dart';

import '../Data.dart';

class DryCleaningTile extends StatefulWidget {
  final int index;
  DryCleaningTile({this.index});
  @override
  _DryCleaningTileState createState() => _DryCleaningTileState();
}

class _DryCleaningTileState extends State<DryCleaningTile> {
  void addDryCleaningQty(int index) {
    setState(() {
      Database.dryCleaningDataItems[index]['qty'] += 1;
      Database.dryCleaningDataItems[index]['total_item_cost'] +=
          Database.dryCleaningDataItems[index]['price'];
    });
    //print(Database.ironingDataItems[index]['total_item_cost'].toString());
  }

  void subtractDryCleaningQty(int index) {
    if (Database.dryCleaningDataItems[index]['qty'] > 0) {
      setState(() {
        Database.dryCleaningDataItems[index]['qty'] -= 1;
        Database.dryCleaningDataItems[index]['total_item_cost'] -=
            Database.dryCleaningDataItems[index]['price'];
      });
    }
    //print(Database.ironingDataItems[index]['total_item_cost'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListTile(
          title: Text(Database.dryCleaningDataItems[widget.index]['title']),
          subtitle: Text("₹ " +
              Database.dryCleaningDataItems[widget.index]['price'].toString()),
          //onTap: isPanelVisible,
          leading: CircleAvatar(child: Text("AZ")),
          trailing: SizedBox(
            width: 120,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      subtractDryCleaningQty(widget.index);
                    }),
                Text(Database.dryCleaningDataItems[widget.index]['qty']
                    .toString()),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addDryCleaningQty(widget.index);
                    }),
              ],
            ),
          ),
        ),
        Divider(),
      ]),
    );
  }
}
