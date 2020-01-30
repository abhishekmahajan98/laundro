import 'package:flutter/material.dart';

import '../Data.dart';



class WashingTile extends StatefulWidget {
  final int index;
  WashingTile({this.index});
  @override
  _WashingTileState createState() => _WashingTileState();
}

class _WashingTileState extends State<WashingTile> {
  void addWashingQty(int index){
    setState(() {
      Database.washingDataItems[index]['qty']+=1;
      Database.washingDataItems[index]['total_item_cost']+=Database.washingDataItems[index]['price'];
    });
    //print(Database.washingDataItems[index]['total_item_cost'].toString());
  }
  void subtractWashingQty(int index){
    if(Database.washingDataItems[index]['qty']>0){
      setState(() {
         Database.washingDataItems[index]['qty']-=1;
         Database.washingDataItems[index]['total_item_cost']-=Database.washingDataItems[index]['price'];
      });
    }
    //print(Database.washingDataItems[index]['total_item_cost'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListTile(
          title: Text(Database.washingDataItems[widget.index]['title']),
          subtitle: Text("₹ " + Database.washingDataItems[widget.index]['price'].toString()),
          //onTap: isPanelVisible,
          leading: CircleAvatar(child: Text("AZ")),
          trailing: SizedBox(
              width: 120,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.remove
                    ), 
                    onPressed: (){
                      subtractWashingQty(widget.index);
                    }
                  ),
                  Text(
                    Database.washingDataItems[widget.index]['qty'].toString()
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add
                    ), 
                    onPressed: (){
                      addWashingQty(widget.index);
                    }
                  ),
                ],
              ),
            ),
          ),
        Divider(),
        ] 
      ),
    );
  }
}