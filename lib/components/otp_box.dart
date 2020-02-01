import 'package:flutter/material.dart';

class OtpBox extends StatelessWidget {
  OtpBox({
    this.orderId,
    this.orderStatus,
    this.serviceName,
    this.deliveryOtp,
    this.pickupOtp,
    this.isPickedUp,
    this.shopPhoneNumber,
  });
  final String orderId;
  final String pickupOtp;
  final String deliveryOtp;
  final String serviceName;
  final String orderStatus;
  final bool isPickedUp;
  final String shopPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text('Order Id:'),
            trailing: Text(orderId),
          ),
          ListTile(
            leading: Text('Service Name:'),
            trailing: Text(
              serviceName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Text('Order Status:'),
            trailing: Text(
              orderStatus != 'accepted'
                  ? 'Awaiting Shop Acceptance'
                  : 'Accepted',
              style: TextStyle(
                color: orderStatus != 'accepted' ? Colors.red : Colors.green,
              ),
            ),
          ),
          ListTile(
            leading: Text('Shop Phone Number:'),
            trailing: Text(shopPhoneNumber),
          ),
          isPickedUp == false
              ? ListTile(
                  leading: Text('Pick-up OTP:'),
                  trailing: Text(
                    pickupOtp,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 30),
                  ),
                )
              : ListTile(
                  leading: Text('Delivery OTP:'),
                  trailing: Text(
                    deliveryOtp,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 30),
                  ),
                ),
        ],
      ),
    );
  }
}
