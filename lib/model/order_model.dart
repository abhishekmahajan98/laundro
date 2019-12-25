

class Order {
  static String orderId ;
  static String instruction;
  static double deliveryCost = 0;
  static double total;
  static String otp;
  static DateTime orderPlacedDateTime;
  static DateTime deliveryDateTime;
  static List<dynamic> orderItemList;
  static Map<dynamic, dynamic> userDetail = {
    "userId": null,
    "phone": null,
    "address": null,
    "pincode": null
  };
  static Map<dynamic, dynamic> shopDetail = {
    "shopId": null,
    "name": null,
  };
  static Map<dynamic, bool> orderStatus = {
    "hasAccepted ": false,
    "hasPickedUp ": false,
    // "hasProcessed": false,
    "hasDelivered": false,
  };
  static Map<dynamic, dynamic> paymentDetail = {
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
