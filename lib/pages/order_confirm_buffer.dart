import 'dart:async';
import 'dart:math';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:uuid/uuid.dart';



class OrderConfirmBuffer extends StatefulWidget {
  @override
  _OrderConfirmBufferState createState() => _OrderConfirmBufferState();
}

class _OrderConfirmBufferState extends State<OrderConfirmBuffer> {
  var uuid=Uuid();
  static final Firestore _firestore=Firestore.instance;
  bool ironOrder=false,washingOrder=false,dryCleaning;
  var batch=_firestore.batch();


  int getOtp(int min, int max) => min + Random.secure().nextInt(max - min);

  Map getClothList(List serviceList){
    Map<String,String> clothList={};
    for(var i=0;i<serviceList.length;i++){
      clothList[serviceList[i]['title']]=serviceList[i]['qty'].toString();
    }
    return clothList;
  }
  void checkIroningOrder(){
    double ironingDeliveryCost=0;
    if(Order.ironingNumber>0){
      if(Order.deliveryCost>0){
        ironingDeliveryCost=Order.ironingNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedIroningList);
      String orderid=uuid.v1().split('-').join();
      String pickupOtp=getOtp(1000, 10000).toString();
      String deliveryOtp=getOtp(1000, 10000).toString();
      //TODO : GET SHOP ID AND PHONE ACCORDING TO ADDRESS AND AREA.
      //TODO : GET SERVICE AREA FROM CUSTOMER
      batch.setData(
        _firestore.collection('orders').document(orderid),
        {
          'customerName':User.displayName,
          'customerPhoneNumber':User.phone,
          'customerUid':User.uid,
          'shopId':'V82NM6YNC0YNgPznoZR3Yxae5AI3',
          'shopPhoneNumber':'9810163269',
          'subscription':"none",
          'subscriptionId':"none",
          'isPickedUp':false,
          'clothList':clothList,
          'totalClothes':Order.ironingNumber.toString(),
          'totalOrderPrice':(Order.ironingCost+ironingDeliveryCost).toString(),
          'orderCommission':(ironingDeliveryCost/2).toString(),
          'orderDeliveryPricePayable':(ironingDeliveryCost/2).toString(),
          'orderDeliveryPrice':ironingDeliveryCost.toString(),
          'orderStatus':'confirmed',
          'orderSubtotal':Order.ironingCost.toString(),
          'orderTimestamp':DateTime.now(),
          'orderid':orderid,
          'pickupOtp':pickupOtp.toString(),
          'deliveryOtp':deliveryOtp.toString(),
          'paymentId':'not applicable',
          'serviceArea':'Potheri',
          'addressLine1':User.primaryAddressLine1,
          'addressLine2':User.primaryAddressLine2,
          'city':User.primaryAddressCity,
          'state':User.primaryAddressState,
          'pincode':User.pincode,
          'primaryAddress':User.primaryAddress,
          'paymentMethod':Order.paymentType,
          'serviceName':'Ironing',
        }
      );
    }
  }
  void checkWashingOrder(){
    double washingDeliveryCost=0;
    if(Order.washingNumber>0){
      if(Order.deliveryCost>0){
        washingDeliveryCost=Order.washingNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedWashingList);
      String orderid=uuid.v1().split('-').join();
      String pickupOtp=getOtp(1000, 10000).toString();
      String deliveryOtp=getOtp(1000, 10000).toString();
      //TODO : GET SHOP ID AND PHONE ACCORDING TO ADDRESS AND AREA.
      //TODO : GET SERVICE AREA FROM CUSTOMER
      batch.setData(
        _firestore.collection('orders').document(orderid),
        {
          'customerName':User.displayName,
          'customerPhoneNumber':User.phone,
          'customerUid':User.uid,
          'shopId':'V82NM6YNC0YNgPznoZR3Yxae5AI3',
          'shopPhoneNumber':'9810163269',
          'subscription':"none",
          'subscriptionId':"none",
          'isPickedUp':false,
          'clothList':clothList,
          'totalClothes':Order.washingNumber.toString(),
          'totalOrderPrice':(Order.washingCost+washingDeliveryCost).toString(),
          'orderCommission':(washingDeliveryCost/2).toString(),
          'orderDeliveryPricePayable':(washingDeliveryCost/2).toString(),
          'orderDeliveryPrice':washingDeliveryCost.toString(),
          'orderStatus':'confirmed',
          'orderSubtotal':Order.washingCost.toString(),
          'orderTimestamp':DateTime.now(),
          'orderid':orderid.toString(),
          'pickupOtp':pickupOtp.toString(),
          'deliveryOtp':deliveryOtp.toString(),
          'paymentId':'not applicable',
          'serviceArea':'Potheri',
          'addressLine1':User.primaryAddressLine1,
          'addressLine2':User.primaryAddressLine2,
          'city':User.primaryAddressCity,
          'state':User.primaryAddressState,
          'pincode':User.pincode,
          'primaryAddress':User.primaryAddress,
          'paymentMethod':Order.paymentType,
          'serviceName':'Washing',
        }
      );
    }
  }
  void checkDryCleaningOrder(){
    double dryCleaningDeliveryCost=0;
    if(Order.dryCleaningNumber>0){
      if(Order.deliveryCost>0){
        dryCleaningDeliveryCost=Order.dryCleaningNumber.toDouble();
      }
      Map clothList = getClothList(Order.selectedDryCleaningList);
      String orderid=uuid.v1().split('-').join();
      String pickupOtp=getOtp(1000, 10000).toString();
      String deliveryOtp=getOtp(1000, 10000).toString();
      //TODO : GET SHOP ID AND PHONE ACCORDING TO ADDRESS AND AREA.
      //TODO : GET SERVICE AREA FROM CUSTOMER
      batch.setData(
        _firestore.collection('orders').document(orderid),
        {
          'customerName':User.displayName,
          'customerPhoneNumber':User.phone,
          'customerUid':User.uid,
          'shopId':'V82NM6YNC0YNgPznoZR3Yxae5AI3',
          'shopPhoneNumber':'9810163269',
          'subscription':"none",
          'subscriptionId':"none",
          'isPickedUp':false,
          'clothList':clothList,
          'totalClothes':Order.dryCleaningNumber.toString(),
          'totalOrderPrice':(Order.dryCleaningCost+dryCleaningDeliveryCost).toString(),
          'orderCommission':(dryCleaningDeliveryCost/2).toString(),
          'orderDeliveryPricePayable':(dryCleaningDeliveryCost/2).toString(),
          'orderDeliveryPrice':dryCleaningDeliveryCost.toString(),
          'orderStatus':'confirmed',
          'orderSubtotal':Order.dryCleaningCost.toString(),
          'orderTimestamp':DateTime.now(),
          'orderid':orderid,
          'pickupOtp':pickupOtp.toString(),
          'deliveryOtp':deliveryOtp.toString(),
          'paymentId':'not applicable',
          'serviceArea':'Potheri',
          'addressLine1':User.primaryAddressLine1,
          'addressLine2':User.primaryAddressLine2,
          'city':User.primaryAddressCity,
          'state':User.primaryAddressState,
          'pincode':User.pincode,
          'primaryAddress':User.primaryAddress,
          'paymentMethod':Order.paymentType,
          'serviceName':'Dry Cleaning',
        }
      );
    }
  }
  void batchCommit(){
    try{
      batch.commit();
    }
    catch(e){
      print(e);
    }
  }
  void navigateToConfirmationPage(){
    Navigator.pushNamed(context, '/order_confirm_page');
  }
  @override
  void initState(){
    super.initState();
    checkIroningOrder();
    checkWashingOrder();
    checkDryCleaningOrder();
    batchCommit();
    //navigateToConfirmationPage();
    //TODO: CLEAR CART AFTER COMMIT
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
              style:kWhiteTitleTextStyle,
              ),
          ],
        ),
      ),
    );
  }
}