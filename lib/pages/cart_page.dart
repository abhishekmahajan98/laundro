import 'package:flutter/material.dart';
import 'package:laundro/components/payment_bottom_sheet.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/screen_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Data.dart';
import '../constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool showspinner = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      showspinner = true;
    });
    valuesReset();
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
      showspinner = false;
    });
  }

  void valuesReset() {
    Order.ironingCost = 0;
    Order.washingCost = 0;
    Order.dryCleaningCost = 0;
    Order.ironingNumber = 0;
    Order.washingNumber = 0;
    Order.dryCleaningNumber = 0;
    Order.subTotal = 0;
    Order.deliveryCost = 0;
    Order.totalCost = 0;
    Order.selectedIroningList.clear();
    Order.selectedWashingList.clear();
    Order.selectedDryCleaningList.clear();
  }

  void getSelectedIroningItems() {
    for (var i = 0; i < Database.ironingDataItems.length; i++) {
      if (Database.ironingDataItems[i]['qty'] > 0) {
        Map selectedItem = {
          'title': Database.ironingDataItems[i]['title'],
          'qty': Database.ironingDataItems[i]['qty'],
          'price': Database.ironingDataItems[i]['price'],
          'total_item_cost': Database.ironingDataItems[i]['total_item_cost'],
        };
        setState(() {
          Order.selectedIroningList.add(selectedItem);
        });
      }
    }
  }

  void getSelectedWashingItems() {
    for (var i = 0; i < Database.washingDataItems.length; i++) {
      if (Database.washingDataItems[i]['qty'] > 0) {
        Map selectedItem = {
          'title': Database.washingDataItems[i]['title'],
          'qty': Database.washingDataItems[i]['qty'],
          'price': Database.washingDataItems[i]['price'],
          'total_item_cost': Database.washingDataItems[i]['total_item_cost'],
        };
        setState(() {
          Order.selectedWashingList.add(selectedItem);
        });
      }
    }
  }

  void getSelectedDryCleaningItems() {
    for (var i = 0; i < Database.dryCleaningDataItems.length; i++) {
      if (Database.dryCleaningDataItems[i]['qty'] > 0) {
        Map selectedItem = {
          'title': Database.dryCleaningDataItems[i]['title'],
          'qty': Database.dryCleaningDataItems[i]['qty'],
          'price': Database.dryCleaningDataItems[i]['price'],
          'total_item_cost': Database.dryCleaningDataItems[i]
              ['total_item_cost'],
        };
        setState(() {
          Order.selectedDryCleaningList.add(selectedItem);
        });
      }
    }
  }

  void getIronDetails() {
    for (var i = 0; i < Order.selectedIroningList.length; i++) {
      setState(() {
        Order.ironingCost += Order.selectedIroningList[i]['total_item_cost'];
        Order.ironingNumber += Order.selectedIroningList[i]['qty'];
      });
    }
  }

  void getWashingDetails() {
    for (var i = 0; i < Order.selectedWashingList.length; i++) {
      setState(() {
        Order.washingCost += Order.selectedWashingList[i]['total_item_cost'];
        Order.washingNumber += Order.selectedWashingList[i]['qty'];
      });
    }
  }

  void getDryCleaningDetails() {
    for (var i = 0; i < Order.selectedDryCleaningList.length; i++) {
      setState(() {
        Order.dryCleaningCost +=
            Order.selectedDryCleaningList[i]['total_item_cost'];
        Order.dryCleaningNumber += Order.selectedDryCleaningList[i]['qty'];
      });
    }
  }

  void getSubTotal() {
    setState(() {
      Order.subTotal =
          Order.ironingCost + Order.washingCost + Order.dryCleaningCost;
    });
  }

  void getTotalClothes() {
    setState(() {
      Order.totalNumber =
          Order.ironingNumber + Order.dryCleaningNumber + Order.washingNumber;
    });
  }

  void getDeliveryPrice() {
    setState(() {
      if (Order.subTotal < 100) {
        Order.deliveryCost += Order.totalNumber;
      } else {
        Order.deliveryCost = 0;
      }
    });
  }

  void getTotalCost() {
    setState(() {
      Order.totalCost = Order.subTotal + Order.deliveryCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: mainColor,
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
                  Order.selectedIroningList.length != 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/iron');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('IR'),
                              ),
                              title: Text('Ironing'),
                              subtitle: Text('Total clothes:' +
                                  Order.ironingNumber.toString()),
                              trailing: Text('Cost: ' +
                                  '₹' +
                                  Order.ironingCost.toString()),
                            ),
                          ),
                        )
                      : Container(),
                  Order.selectedIroningList.length != 0
                      ? Divider()
                      : Container(),
                  Order.selectedWashingList.length != 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/wash');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('WA'),
                              ),
                              title: Text('Washing'),
                              subtitle: Text('Total clothes:' +
                                  Order.washingNumber.toString()),
                              trailing: Text('Cost: ' +
                                  '₹' +
                                  Order.washingCost.toString()),
                            ),
                          ),
                        )
                      : Container(),
                  Order.selectedWashingList.length != 0
                      ? Divider()
                      : Container(),
                  Order.selectedDryCleaningList.length != 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/dry-clean');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('DR'),
                              ),
                              title: Text('Dry cleaning'),
                              subtitle: Text('Total clothes:' +
                                  Order.dryCleaningNumber.toString()),
                              trailing: Text('Cost: ' +
                                  '₹' +
                                  Order.dryCleaningCost.toString()),
                            ),
                          ),
                        )
                      : Container(),
                  Order.selectedDryCleaningList.length != 0
                      ? Divider()
                      : Container(),
                ],
              ),
            ),
            Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sub total:'),
                        Text('₹' + Order.subTotal.toString()),
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
                          Order.deliveryCost == 0
                              ? 'Free'
                              : Order.deliveryCost.toString(),
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
                        Text('₹' + Order.totalCost.toString()),
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
                color: Order.subTotal >= 30 ? Colors.green : Colors.red,
                onPressed: () {
                  if (User.selectedShopId != '' ||
                      User.selectedShopId != null) {
                    if (Order.subTotal >= 30) {
                      showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return ShowPaymentBottom();
                        },
                      );
                    } else {
                      Alert(
                        context: context,
                        title: 'Minimun subtotal is of ₹30.',
                        desc: 'We do not accept orders below ₹30.',
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Okay'),
                          ),
                        ],
                      ).show();
                    }
                  } else {
                    Alert(
                      context: context,
                      title: 'Shop is not selected',
                      desc:
                          'Please select the shop for your location from My Account',
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.pop(context);
                            HomeIdx.selectedIndex = 2;
                          },
                          child: Text('Okay'),
                        ),
                      ],
                    ).show();
                  }
                },
                child: Text(
                  'Proceed to Checkout',
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
