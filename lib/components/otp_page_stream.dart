import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/components/otp_box.dart';
import 'package:laundro/model/user_model.dart';

final _firestore = Firestore.instance;

class OtpStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('orders')
          .where("customerUid", isEqualTo: User.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final documents = snapshot.data.documents;
        List<OtpBox> otpList = [];
        for (var doc in documents) {
          final String orderId = doc.data['orderid'];
          final String pickupOtp = doc.data['pickupOtp'];
          final String deliveryOtp = doc.data['deliveryOtp'];
          final String serviceName = doc.data['serviceName'];
          final String orderStatus = doc.data['orderStatus'];
          final bool isPickedUp = doc.data['isPickedUp'];
          final String shopPhoneNumber = doc.data['shopPhoneNumber'];
          if (orderStatus != 'delivered') {
            otpList.add(OtpBox(
              orderId: orderId,
              pickupOtp: pickupOtp,
              deliveryOtp: deliveryOtp,
              serviceName: serviceName,
              orderStatus: orderStatus,
              isPickedUp: isPickedUp,
              shopPhoneNumber: shopPhoneNumber,
            ));
          }
        }
        return Expanded(
          child: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              children:
                  otpList.length == 0 ? [Text('No orders to show')] : otpList),
        );
      },
    );
  }
}
