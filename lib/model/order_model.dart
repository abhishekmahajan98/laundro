import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundro/model/items_model.dart';
import 'package:laundro/model/payment_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:uuid/uuid.dart';

class Order {
  String orderId;
  String instruction;
  String otp;
  double total;
  double deliveryCost;
  DateTime orderPlacedDateTime = DateTime.now();
  DateTime deliveryDateTime;
  bool orderIsAccepted = false;
  bool orderIsPickedUp = false;
  bool orderIsDelivered = false;
  Map shop;
  Map orderItems;
  Map user;
  Map payment;

  Order(
      {this.orderId,
      this.instruction,
      this.total,
      this.deliveryCost,
      this.otp,
      this.orderPlacedDateTime,
      this.deliveryDateTime,
      this.orderItems,
      this.user,
      this.shop,
      this.orderIsAccepted,
      this.orderIsPickedUp,
      this.orderIsDelivered,
      this.payment});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    instruction = json['instruction'];
    total = json['total'];
    otp = json['otp'];
    deliveryCost = json['deliveryCost'];
    orderPlacedDateTime = json['orderPlacedDateTime'];
    deliveryDateTime = json['deliveryDateTime'];
    orderItems = json['orderItems'];
    user = json['user'];
    shop = json['shop'];
    orderIsAccepted = json['orderIsAccepted'];
    orderIsPickedUp = json['orderIsPickedUp'];
    orderIsDelivered = json['orderIsDelivered'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['instruction'] = this.instruction;
    data['total'] = this.total;
    data['otp'] = this.otp;
    data['deliveryCost'] = this.deliveryCost;
    data['orderPlacedDateTime'] = this.orderPlacedDateTime;
    data['deliveryDateTime'] = this.deliveryDateTime;
    data['orderItems'] = this.orderItems;
    data['user'] = this.user;
    data['shop'] = this.shop;
    data['orderIsAccepted'] = this.orderIsAccepted;
    data['orderIsPickedUp'] = this.orderIsPickedUp;
    data['orderIsDelivered'] = this.orderIsDelivered;
    data['payment'] = this.payment;
    return data;
  }

  void generateOrderId() {
    this.orderId = Uuid().v1().split("-")[4];
  }

  void generateOTP() {
    this.otp = Uuid().v1().split("-")[1];
  }

  Map<String, dynamic> getFilteredOrder() {
    final orderMap = {...this.toJson()};
    orderMap.remove("user");
    return orderMap;
  }

  static Future<void> create(String razorpayId, double deliveryCost) async {
    double amount = 0;
    // user operations
    User user = await User.getPrefUser();
    final userRef = Firestore.instance.collection("users").document(user.uid);

    // item operations
    Items ironItems = await Items.getItemsPref("iron");
    Items washItems = await Items.getItemsPref('wash');
    Items drycleanItems = await Items.getItemsPref('dryclean');

    amount += ironItems.total + washItems.total + drycleanItems.total;

    // payment operations
    Payment payment = Payment();
    payment.generatePaymentId();
    payment.razorpayId = razorpayId;
    payment.user = user.getFilteredUser();
    payment.amount = amount;
    final paymentRef = Firestore.instance.collection("payments").document();

    // transaction operations
    await Firestore.instance.runTransaction((Transaction t) async {
      if (ironItems.total > 0) {
        final ironOrder = Order();
        ironOrder.generateOrderId();
        ironOrder.generateOTP();
        ironOrder.total = ironItems.total;
        ironOrder.deliveryCost = deliveryCost / 3;
        ironOrder.orderItems = ironItems.getFilteredItems();
        ironOrder.user = user.getFilteredUser();
        ironOrder.payment = payment.getFilteredPayment();
        final ironRef = Firestore.instance.collection("orders").document();
        user.orderHistory.putIfAbsent(
            ironRef.documentID, () => ironOrder.getFilteredOrder());
        t.set(ironRef, ironOrder.toJson());
      }
      if (washItems.total > 0) {
        final washOrder = Order();
        washOrder.generateOrderId();
        washOrder.generateOTP();
        washOrder.total = washItems.total;
        washOrder.deliveryCost = deliveryCost / 3;
        washOrder.orderItems = washItems.getFilteredItems();
        washOrder.user = user.getFilteredUser();
        washOrder.payment = payment.getFilteredPayment();
        final washRef = Firestore.instance.collection("orders").document();
        user.orderHistory.putIfAbsent(
            washRef.documentID, () => washOrder.getFilteredOrder());
        t.set(washRef, washOrder.toJson());
      }
      if (drycleanItems.total > 0) {
        final drycleanOrder = Order();
        drycleanOrder.generateOrderId();
        drycleanOrder.generateOTP();
        drycleanOrder.total = drycleanItems.total;
        drycleanOrder.deliveryCost = deliveryCost / 3;
        drycleanOrder.orderItems = drycleanItems.getFilteredItems();
        drycleanOrder.user = user.getFilteredUser();
        drycleanOrder.payment = payment.getFilteredPayment();
        final drycleanRef = Firestore.instance.collection("orders").document();
        user.orderHistory.putIfAbsent(
            drycleanRef.documentID, () => drycleanOrder.getFilteredOrder());
        t.set(drycleanRef, drycleanOrder.toJson());
      }
      t.set(paymentRef, payment.toJson());
      t.set(userRef, user.toJson());
    });
  }
}
