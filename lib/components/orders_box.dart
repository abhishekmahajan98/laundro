import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/pages/cloth_details.dart';

class OrdersBox extends StatefulWidget {
  OrdersBox({
    @required this.orderId,
    @required this.customerName,
    @required this.serviceType,
    @required this.customerPhoneNumber,
    @required this.primaryAddress,
    @required this.totalClothes,
    @required this.paymentMethod,
    @required this.totalOrderprice,
    @required this.orderSubtotal,
    @required this.isPickedUp,
    @required this.clothList,
    @required this.pickupOtp,
    @required this.deliveryOtp,
    @required this.locality,
    @required this.placeName,
    @required this.pincode,
    @required this.administrativeArea,
    @required this.lattitude,
    @required this.longitude,
    @required this.landmark,
    @required this.orderStatus,
  });
  final String customerName;
  final String orderId;
  final String orderStatus;
  final String serviceType;
  final String customerPhoneNumber;
  final String primaryAddress;
  final String landmark;
  final String locality;
  final String pincode;
  final String administrativeArea;
  final String placeName;
  final double lattitude;
  final double longitude;
  final String totalClothes;
  final String paymentMethod;
  final String totalOrderprice;
  final String orderSubtotal;
  final bool isPickedUp;
  final String pickupOtp;
  final String deliveryOtp;
  final Map<dynamic, dynamic> clothList;
  @override
  _OrdersBoxState createState() => _OrdersBoxState();
}

class _OrdersBoxState extends State<OrdersBox> {
  List<ListTile> clothes = [];
  @override
  void initState() {
    super.initState();
    widget.clothList.forEach((k, v) {
      ListTile lt = ListTile(
        leading: Text(
          k.toString(),
          style: kBlackLabelStyle,
        ),
        trailing: Text('Quantity=' + v.toString()),
      );
      clothes.add(lt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Text('Service Type:'),
            trailing: Text(
              widget.serviceType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 30,
              ),
            ),
          ),
          ListTile(
            leading: Text('Order Id:'),
            trailing: Text(widget.orderId),
          ),
          ListTile(
            leading: Text('Order Status:'),
            trailing: Text(
              widget.orderStatus == 'confirmed'
                  ? 'Awaiting Shop Acceptance'
                  : widget.orderStatus == 'accepted' ? "Accepted" : "Delivered",
              style: TextStyle(
                color: widget.orderStatus == 'confirmed'
                    ? Colors.red
                    : widget.orderStatus == 'accepted'
                        ? Colors.yellow
                        : Colors.green,
              ),
            ),
          ),
          ListTile(
            leading: Text('Phone:'),
            trailing: Text(widget.customerPhoneNumber),
          ),
          ListTile(
            leading: Text('Primary Address'),
            trailing: Text(widget.primaryAddress),
          ),
          ListTile(
            leading: Text('Landmark'),
            trailing: Text(widget.landmark),
          ),
          ListTile(
            leading: Text('Place name'),
            trailing: Text(widget.placeName),
          ),
          ListTile(
            leading: Text('Locality'),
            trailing: Text(widget.locality),
          ),
          ListTile(
            leading: Text('Order Id:'),
            trailing: Text('Administrative Area:' + widget.administrativeArea),
          ),
          ListTile(
            leading: Text('Pincode:'),
            trailing: Text(widget.pincode),
          ),
          ListTile(
            leading: Text('total clothes:' + widget.totalClothes),
            trailing: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothDetails(
                      clothList: clothes,
                    ),
                  ),
                );
              },
              child: Text('Clothes details'),
            ),
          ),
        ],
      ),
    );
  }
}
