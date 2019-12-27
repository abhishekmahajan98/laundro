import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundro/components/orders_box.dart';
import 'package:laundro/model/user_model.dart';


final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
class OrdersStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('orders').where("customerUid", isEqualTo: User.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<OrdersBox> orders = [];
        for (var message in messages) {
          final orderId = message.data['orderid'];
          final customerName = message.data['customerName'];
          final serviceType = message.data['serviceName'];
          final customerPhoneNumber=message.data['customerPhoneNumber'];
          final addressline1=message.data['addressLine1'];
          final addressline2=message.data['addressLine2'];
          final city=message.data['city'];
          final state=message.data['state'];
          final pincode=message.data['pincode'];
          final serviceArea=message.data['serviceArea'];
          final totalClothes=message.data['totalClothes'];
          final paymentMethod=message.data['paymentMethod'];
          final totalOrderprice=message.data['totalOrderPrice'];
          final orderSubtotal=message.data['orderSubtotal'];
          final isPickedUp=message.data['isPickedUp'];
          final clothList=message.data['clothList'];
          final otp=message.data['otp'];
          final OrdersBox order = OrdersBox(
            orderId: orderId,
            customerName: customerName,
            serviceType: serviceType,
            customerPhoneNumber: customerPhoneNumber,
            addressline1: addressline1,
            addressline2: addressline2,
            city: city,
            state: state,
            pincode: pincode,
            serviceArea: serviceArea,
            totalClothes: totalClothes,
            paymentMethod: paymentMethod,
            totalOrderprice: totalOrderprice,
            orderSubtotal: orderSubtotal,
            isPickedUp: isPickedUp,
            clothList: clothList,
            otp:otp,
          );
          orders.add(order);
        }
        return Expanded(
          child:ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
            children: orders.length==0?[Text('No orders to show')]:orders,
          ),
        );
      }
    );
  }
}