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
        stream: _firestore
            .collection('orders')
            .where("customerUid", isEqualTo: User.uid)
            .orderBy('orderTimestamp', descending: true)
            .snapshots(),
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
            final customerPhoneNumber = message.data['customerPhoneNumber'];
            final totalClothes = message.data['totalClothes'];
            final paymentMethod = message.data['paymentMethod'];
            final totalOrderprice = message.data['totalOrderPrice'];
            final orderSubtotal = message.data['orderSubtotal'];
            final isPickedUp = message.data['isPickedUp'];
            final clothList = message.data['clothList'];
            final pincode = message.data['pincode'];
            final primaryAddress = message.data['primaryAddress'];
            final landmark = message.data['landmark'];
            final locality = message.data['locality'];
            final administrativeArea = message.data['administrativeArea'];
            final placeName = message.data['placeName'];
            final deliveryOtp = message.data['deliveryOtp'];
            final pickupOtp = message.data['pickupOtp'];
            final orderStatus = message.data['orderStatus'];
            final GeoPoint geoLocation = message.data['geoLocation'];
            final lattitude = geoLocation.latitude.toDouble();
            final longitude = geoLocation.longitude.toDouble();
            final OrdersBox order = OrdersBox(
              orderId: orderId,
              customerName: customerName,
              serviceType: serviceType,
              customerPhoneNumber: customerPhoneNumber,
              placeName: placeName,
              landmark: landmark,
              administrativeArea: administrativeArea,
              locality: locality,
              lattitude: lattitude,
              longitude: longitude,
              primaryAddress: primaryAddress,
              pincode: pincode,
              totalClothes: totalClothes,
              paymentMethod: paymentMethod,
              totalOrderprice: totalOrderprice,
              orderSubtotal: orderSubtotal,
              isPickedUp: isPickedUp,
              clothList: clothList,
              pickupOtp: pickupOtp,
              deliveryOtp: deliveryOtp,
              orderStatus: orderStatus,
            );
            orders.add(order);
          }
          return Expanded(
            child: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              children:
                  orders.length == 0 ? [Text('No orders to show')] : orders,
            ),
          );
        });
  }
}
