import 'dart:math';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/Data.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:uuid/uuid.dart';

class OrderConfirmBuffer extends StatefulWidget {
  OrderConfirmBuffer(
      {@required this.allocatedShopId,
      @required this.allocatedShopPhoneNumber});
  final String allocatedShopId;
  final String allocatedShopPhoneNumber;
  @override
  _OrderConfirmBufferState createState() => _OrderConfirmBufferState();
}

class _OrderConfirmBufferState extends State<OrderConfirmBuffer> {
  var uuid = Uuid();
  static final Firestore _firestore = Firestore.instance;
  bool ironOrder = false, washingOrder = false, dryCleaning;
  var batch = _firestore.batch();
  DateTime timeNow = DateTime.now();

  int getOtp(int min, int max) => min + Random.secure().nextInt(max - min);

  Map getClothList(List serviceList) {
    Map<String, String> clothList = {};
    for (var i = 0; i < serviceList.length; i++) {
      clothList[serviceList[i]['title']] = serviceList[i]['qty'].toString();
    }
    return clothList;
  }

  void checkIroningOrder() {
    double ironingDeliveryCost = 0;
    if (Order.ironingNumber > 0) {
      if (Order.deliveryCost > 0) {
        ironingDeliveryCost = Order.ironingNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedIroningList);
      String randomId = uuid.v1().split('-')[0];
      String timeId = timeNow.day.toString() +
          timeNow.month.toString() +
          timeNow.year.toString();
      String customerIdPart = User.uid.substring(0, 4);
      String orderid = 'I' + timeId + '-' + randomId + '-' + customerIdPart;
      String pickupOtp = getOtp(1000, 10000).toString();
      String deliveryOtp = getOtp(1000, 10000).toString();
      batch.setData(_firestore.collection('orders').document(orderid), {
        'customerName': User.displayName,
        'customerPhoneNumber': User.phone,
        'customerUid': User.uid,
        'shopId': widget.allocatedShopId,
        'shopPhoneNumber': widget.allocatedShopPhoneNumber,
        'subscription': "none",
        'subscriptionId': "none",
        'isPickedUp': false,
        'clothList': clothList,
        'totalClothes': Order.ironingNumber.toString(),
        'totalOrderPrice': (Order.ironingCost + ironingDeliveryCost).toString(),
        'orderCommission': (ironingDeliveryCost / 2).toString(),
        'orderDeliveryPricePayable': (ironingDeliveryCost / 2).toString(),
        'orderDeliveryPrice': ironingDeliveryCost.toString(),
        'orderStatus': 'confirmed',
        'orderSubtotal': Order.ironingCost.toString(),
        'orderTimestamp': timeNow,
        'orderid': orderid,
        'pickupOtp': pickupOtp.toString(),
        'deliveryOtp': deliveryOtp.toString(),
        'paymentId': 'not applicable',
        'locality': User.locality,
        'administrativeArea': User.administrativeArea,
        'placeName': User.placeName,
        'pincode': User.pincode,
        'primaryAddress': User.primaryAddress,
        'landmark': User.landmark,
        'geoLocation': GeoPoint(User.lattitude, User.longitude),
        'paymentMethod': Order.paymentType,
        'serviceName': 'Ironing',
      });
    }
  }

  void checkWashingOrder() {
    double washingDeliveryCost = 0;
    if (Order.washingNumber > 0) {
      if (Order.deliveryCost > 0) {
        washingDeliveryCost = Order.washingNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedWashingList);
      String randomId = uuid.v1().split('-')[0];
      String timeId = timeNow.day.toString() +
          timeNow.month.toString() +
          timeNow.year.toString();
      String customerIdPart = User.uid.substring(0, 4);
      String orderid = 'W' + timeId + '-' + randomId + '-' + customerIdPart;
      String pickupOtp = getOtp(1000, 10000).toString();
      String deliveryOtp = getOtp(1000, 10000).toString();
      batch.setData(_firestore.collection('orders').document(orderid), {
        'customerName': User.displayName,
        'customerPhoneNumber': User.phone,
        'customerUid': User.uid,
        'shopId': widget.allocatedShopId,
        'shopPhoneNumber': widget.allocatedShopPhoneNumber,
        'subscription': "none",
        'subscriptionId': "none",
        'isPickedUp': false,
        'clothList': clothList,
        'totalClothes': Order.washingNumber.toString(),
        'totalOrderPrice': (Order.washingCost + washingDeliveryCost).toString(),
        'orderCommission': (washingDeliveryCost / 2).toString(),
        'orderDeliveryPricePayable': (washingDeliveryCost / 2).toString(),
        'orderDeliveryPrice': washingDeliveryCost.toString(),
        'orderStatus': 'confirmed',
        'orderSubtotal': Order.washingCost.toString(),
        'orderTimestamp': timeNow,
        'orderid': orderid.toString(),
        'pickupOtp': pickupOtp.toString(),
        'deliveryOtp': deliveryOtp.toString(),
        'paymentId': 'not applicable',
        'locality': User.locality,
        'administrativeArea': User.administrativeArea,
        'placeName': User.placeName,
        'landmark': User.landmark,
        'geoLocation': GeoPoint(User.lattitude, User.longitude),
        'pincode': User.pincode,
        'primaryAddress': User.primaryAddress,
        'paymentMethod': Order.paymentType,
        'serviceName': 'Washing',
      });
    }
  }

  void checkDryCleaningOrder() {
    double dryCleaningDeliveryCost = 0;
    if (Order.dryCleaningNumber > 0) {
      if (Order.deliveryCost > 0) {
        dryCleaningDeliveryCost = Order.dryCleaningNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedDryCleaningList);
      String randomId = uuid.v1().split('-')[0];
      String timeId = timeNow.day.toString() +
          timeNow.month.toString() +
          timeNow.year.toString();
      String customerIdPart = User.uid.substring(0, 4);
      String orderid = 'DC' + timeId + '-' + randomId + '-' + customerIdPart;
      String pickupOtp = getOtp(1000, 10000).toString();
      String deliveryOtp = getOtp(1000, 10000).toString();
      batch.setData(_firestore.collection('orders').document(orderid), {
        'customerName': User.displayName,
        'customerPhoneNumber': User.phone,
        'customerUid': User.uid,
        'shopId': widget.allocatedShopId,
        'shopPhoneNumber': widget.allocatedShopPhoneNumber,
        'subscription': "none",
        'subscriptionId': "none",
        'isPickedUp': false,
        'clothList': clothList,
        'totalClothes': Order.dryCleaningNumber.toString(),
        'totalOrderPrice':
            (Order.dryCleaningCost + dryCleaningDeliveryCost).toString(),
        'orderCommission': (dryCleaningDeliveryCost / 2).toString(),
        'orderDeliveryPricePayable': (dryCleaningDeliveryCost / 2).toString(),
        'orderDeliveryPrice': dryCleaningDeliveryCost.toString(),
        'orderStatus': 'confirmed',
        'orderSubtotal': Order.dryCleaningCost.toString(),
        'orderTimestamp': timeNow,
        'orderid': orderid,
        'pickupOtp': pickupOtp.toString(),
        'deliveryOtp': deliveryOtp.toString(),
        'paymentId': 'not applicable',
        'locality': User.locality,
        'administrativeArea': User.administrativeArea,
        'placeName': User.placeName,
        'pincode': User.pincode,
        'primaryAddress': User.primaryAddress,
        'landmark': User.landmark,
        'geoLocation': GeoPoint(User.lattitude, User.longitude),
        'paymentMethod': Order.paymentType,
        'serviceName': 'Dry Cleaning',
      });
    }
  }

  void clearSelectedIroningItems() {
    for (var i = 0; i < Database.ironingDataItems.length; i++) {
      if (Database.ironingDataItems[i]['qty'] > 0) {
        Database.ironingDataItems[i]['qty'] = 0;
      }
    }
  }

  void clearSelectedWashingItems() {
    for (var i = 0; i < Database.washingDataItems.length; i++) {
      if (Database.washingDataItems[i]['qty'] > 0) {
        Database.washingDataItems[i]['qty'] = 0;
      }
    }
  }

  void clearSelectedDryCleaningItems() {
    for (var i = 0; i < Database.dryCleaningDataItems.length; i++) {
      if (Database.dryCleaningDataItems[i]['qty'] > 0) {
        Database.dryCleaningDataItems[i]['qty'] = 0;
      }
    }
  }

  void clearCart() {
    clearSelectedIroningItems();
    clearSelectedWashingItems();
    clearSelectedDryCleaningItems();
  }

  void batchCommit() {
    try {
      batch.commit().whenComplete(() {
        // clear cart after order added
        clearCart();
        Navigator.pushReplacementNamed(context, '/order_confirmation_page');
      }).catchError((err) {
        print('failed');
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    checkIroningOrder();
    checkWashingOrder();
    checkDryCleaningOrder();
    batchCommit();
    print('batch commited');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF6bacde),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: Colors.white,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Placing the order',
              style: kWhiteTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
