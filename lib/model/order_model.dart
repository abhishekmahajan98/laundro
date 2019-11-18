import 'package:uuid/uuid.dart';

class Order {
  String orderId = Uuid().v4().split("-")[0];
  String instruction;
  double deliveryCost = 0;
  double subTotal;
  DateTime orderPlacedDateTime;
  DateTime deliveryDateTime;
  List<Map<dynamic, dynamic>> orderItemList;
  Map<dynamic, dynamic> userDetail = {
    "userid": null,
    "phone": null,
    "address": null,
    "pincode": null
  };
  Map<dynamic, dynamic> shopDetail = {
    "shopId": null,
    "name": null,
  };
  Map<dynamic, bool> orderStatus = {
    "hasAccepted ": false,
    "hasPickedUp ": false,
    "hasProcessed": false,
    "hasDelivered": false,
  };
  Map<dynamic, dynamic> paymentDetail = {
    "paymentId": null,
    "paymentMode": null
  };
}

// orderItem ={
//   "type":"washing/drycleaning/ironing",
//   "item":"",
//   "qty":"",
//   "costPerItem":""
// }
