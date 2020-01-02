import 'package:flutter/material.dart';
import 'package:laundro/components/payment_bottom_sheet.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../Data.dart';
import '../constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List selectedIroningList=[];
  List selectedWashingList=[];
  List selectedDryCleaningList=[];
  double ironingCost=0,washingCost=0,dryCleaningCost=0;
  double subTotal=0,deliveryCost=0,totalCost=0;
  int ironingNumber=0,washingNumber=0,dryCleaningNumber=0,totalNumber=0;
  bool showspinner=false;
  @override
  void initState() {
    super.initState();
    setState(() {
      showspinner=true;
    });
    getSelectedIroningItems();
    getSelectedWashingItems();
    getSelectedDryCleaningItems();
    getIronDetails();
    getWashingDetails();
    getDryCleaningDetails();
    getSubTotal();
    getTotalClothes();
    getDeliveryPrice();
    getTotalCost();
    setState(() {
      showspinner=false;
    });
  }
  
  void getSelectedIroningItems(){
    for(var i =0;i<Database.ironingDataItems.length;i++){
      if(Database.ironingDataItems[i]['qty']>0){
        Map selectedItem={
          'title':Database.ironingDataItems[i]['title'],
          'qty':Database.ironingDataItems[i]['qty'],
          'price':Database.ironingDataItems[i]['price'],
          'total_item_cost':Database.ironingDataItems[i]['total_item_cost'],
        };
        setState(() {
          selectedIroningList.add(selectedItem);
        });
      }
    }
  }
  void getSelectedWashingItems(){
    for(var i =0;i<Database.washingDataItems.length;i++){
      if(Database.washingDataItems[i]['qty']>0){
        Map selectedItem={
          'title':Database.washingDataItems[i]['title'],
          'qty':Database.washingDataItems[i]['qty'],
          'price':Database.washingDataItems[i]['price'],
          'total_item_cost':Database.washingDataItems[i]['total_item_cost'],
        };
        setState(() {
          selectedWashingList.add(selectedItem);
        });
      }
    }
  }
  void getSelectedDryCleaningItems(){
    for(var i =0;i<Database.dryCleaningDataItems.length;i++){
      if(Database.dryCleaningDataItems[i]['qty']>0){
        Map selectedItem={
          'title':Database.dryCleaningDataItems[i]['title'],
          'qty':Database.dryCleaningDataItems[i]['qty'],
          'price':Database.dryCleaningDataItems[i]['price'],
          'total_item_cost':Database.dryCleaningDataItems[i]['total_item_cost'],
        };
        setState(() {
          selectedDryCleaningList.add(selectedItem);
        });
      }
    }
  }
  void getIronDetails(){
    for(var i =0;i<selectedIroningList.length;i++){
      setState(() {
        ironingCost+=selectedIroningList[i]['total_item_cost'];
        ironingNumber+=selectedIroningList[i]['qty'];
      });
    }
  }
  void getWashingDetails(){
    for(var i =0;i<selectedWashingList.length;i++){
      setState(() {
        washingCost+=selectedWashingList[i]['total_item_cost'];
        washingNumber+=selectedWashingList[i]['qty'];
      });
    }
  }
  void getDryCleaningDetails(){
    for(var i =0;i<selectedDryCleaningList.length;i++){
      setState(() {
        dryCleaningCost+=selectedDryCleaningList[i]['total_item_cost'];
        dryCleaningNumber+=selectedDryCleaningList[i]['qty'];
      });
    }
  }
  void getSubTotal()
  {
    setState(() {
       subTotal=ironingCost+washingCost+dryCleaningCost;
    });
  }
  void getTotalClothes(){
    setState(() {
      totalNumber=ironingNumber+dryCleaningNumber+washingNumber;
    });
    
  }
  void getDeliveryPrice(){
    setState(() {
      if(subTotal<100){
      deliveryCost+=totalNumber;
      }
      else{
        deliveryCost=0;
      }
    });
  }
  void getTotalCost(){
    setState(() {
      totalCost=subTotal+deliveryCost;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Color(0XFF6bacde),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  selectedIroningList.length!=0?GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/iron');
                    },
                    child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('IR'),),
                      title: Text('Ironing'),
                      subtitle: Text('Total clothes:'+ironingNumber.toString()),
                      trailing: Text('Cost: '+'₹'+ironingCost.toString()),
                      ),
                    ),
                  ):Container(),
                selectedIroningList.length!=0?Divider():Container(),
                selectedWashingList.length!=0?GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/wash');
                  },
                 child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('WA'),),
                      title: Text('Washing'),
                      subtitle: Text('Total clothes:'+washingNumber.toString()),
                      trailing: Text('Cost: '+'₹'+washingCost.toString()),
                    ),
                  ),
                ):Container(),
                selectedWashingList.length!=0?Divider():Container(),
                selectedDryCleaningList.length!=0?GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/dry-clean');
                  },
                 child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('DR'),),
                      title: Text('Dry cleaning'),
                      subtitle: Text('Total clothes:'+dryCleaningNumber.toString()),
                      trailing: Text('Cost: '+'₹'+dryCleaningCost.toString()),
                    ),
                  ),
                ):Container(),
                selectedDryCleaningList.length!=0?Divider():Container(),
              ],
            ),
            ),
            Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Divider(thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sub total:'),
                        Text('₹'+subTotal.toString()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delivery:'),
                        Text(
                          deliveryCost==0?'Free':deliveryCost.toString(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total:'),
                        Text('₹'+totalCost.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.green,
                onPressed: (){
                  showModalBottomSheet(context: context, builder: (builder) {
                    return ShowPaymentBottom();
                  });
                },
                child: Text(
                  'Proceed to Payment',
                  style: kLabelStyle,
                  ),
              ),
            )
          ],
        ),
      ),
      );
  }
}