import 'package:flutter/material.dart';
import 'package:laundro/Data.dart';


class IroningTile extends StatefulWidget {
  final int index;
  IroningTile({this.index});
  @override
  _IroningTileState createState() => _IroningTileState();
}

class _IroningTileState extends State<IroningTile> {
  void addIroningQty(int index){
    setState(() {
      Database.ironingDataItems[index]['qty']+=1;
      Database.ironingDataItems[index]['total_item_cost']+=Database.ironingDataItems[index]['price'];
    });
    //print(Database.ironingDataItems[index]['total_item_cost'].toString());
  }
  void subtractIroningQty(int index){
    if(Database.ironingDataItems[index]['qty']>0){
      setState(() {
         Database.ironingDataItems[index]['qty']-=1;
         Database.ironingDataItems[index]['total_item_cost']-=Database.ironingDataItems[index]['price'];
      });
    }
    //print(Database.ironingDataItems[index]['total_item_cost'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(children: <Widget>[
        ListTile(
          title: Text(Database.ironingDataItems[widget.index]['title']),
          subtitle: Text("₹ " + Database.ironingDataItems[widget.index]['price'].toString()),
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
                      subtractIroningQty(widget.index);
                    }
                  ),
                  Text(
                    Database.ironingDataItems[widget.index]['qty'].toString()
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add
                    ), 
                    onPressed: (){
                      addIroningQty(widget.index);
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