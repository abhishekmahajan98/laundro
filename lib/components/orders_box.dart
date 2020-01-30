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
  });
  final String customerName;
  final String orderId;
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
    return ExpansionTile(
      title: Text(widget.customerName,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text('Service Type:' + widget.serviceType),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 50,
        ),
      ),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Order Id:' + widget.orderId),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Phone:' + widget.customerPhoneNumber),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Primary Address' + widget.primaryAddress),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Landmark' + widget.landmark),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Place name' + widget.placeName),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Locality' + widget.locality),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Administrative Area:' + widget.administrativeArea),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Pincode:' + widget.pincode),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Pickup OTP:' + widget.pickupOtp),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('Delivery OTP:' + widget.deliveryOtp),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              title: Text('total clothes:' + widget.totalClothes),
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
      ],
    );
  }
}
