import 'package:flutter/material.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/pages/cloth_details.dart';


class OrdersBox extends StatefulWidget {
  OrdersBox({
  @required this.orderId,
  @required this.customerName,
  @required this.serviceType,
  @required this.customerPhoneNumber,
  @required this.addressline1,
  @required this.addressline2,
  @required this.city,
  @required this.state,
  @required this.pincode,
  @required this.serviceArea,
  @required this.totalClothes,
  @required this.paymentMethod,
  @required this.totalOrderprice,
  @required this.orderSubtotal,
  @required this.isPickedUp,
  @required this.clothList,
  @required this.otp,
  });
  final String customerName;
  final String orderId;
  final String serviceType;
  final String customerPhoneNumber;
  final String addressline1;
  final String addressline2;
  final String city;
  final String state;
  final String pincode;
  final String serviceArea;
  final String totalClothes;
  final String paymentMethod;
  final String totalOrderprice;
  final String orderSubtotal;
  final bool isPickedUp;
  final String otp;
  final Map<dynamic,dynamic> clothList;
  @override
  _OrdersBoxState createState() => _OrdersBoxState();
}

class _OrdersBoxState extends State<OrdersBox> {
    List<ListTile> clothes=[];
  @override
  void initState() {
    super.initState();
    widget.clothList.forEach((k,v){
      ListTile lt=ListTile(
        leading: Text(
          k.toString(),
          style: kBlackLabelStyle,
          ),
        trailing: Text('Quantity='+v.toString()),
      );
      clothes.add(lt);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ExpansionTile(
        title: Text(
          widget.customerName,
          style:TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )
        ),
        subtitle: Text(
          'Service Type:'+
          widget.serviceType
        ),
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
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('Order Id:'+widget.orderId),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('Phone:'+widget.customerPhoneNumber),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('Address Line 1:'+widget.addressline1),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('Address Line 2:'+widget.addressline2),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('city:'+widget.city), 
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title:Text('state:'+widget.state),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('pincode:'+widget.pincode),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                title: Text('total clothes:'+widget.totalClothes),
                trailing: RaisedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClothDetails(clothList: clothes,)),
                      );
                  },
                  child: Text('Clothes details'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}