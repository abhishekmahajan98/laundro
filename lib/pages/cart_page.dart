import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/payment_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

import '../components/cart_list.dart';
import '../components/payment_info_modal.dart';

final _WALLETS = ["paytm", "citrus", "amazonpay", "payzapp", "freecharge"];

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items = [];
  double ironTotal,washingTotal,dryCleaningTotal;
  SharedPreferences _prefs;
  Razorpay _razorpay;
  var iron,wash,dryClean;

  @override
  void initState() {
    super.initState();
    _getData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (response.paymentId != null) {
      var userRef = Firestore.instance.collection("user").document(User.uid);
      var paymentRef = Firestore.instance.collection("payment").document();
      var orderRef = Firestore.instance.collection("order").document();
      final paymentId =Uuid().v4().split("-").sublist(0, 2).join();
      
      final orderId = Uuid().v4().split("-")[0];
      Order.userDetail["userId"] = User.uid;
      Order.userDetail["phone"] = User.phone;
      Order.userDetail["address"] = User.primaryAddress;
      Order.userDetail["pincode"] = User.pincode;
      Order.paymentDetail["paymentId"] = Payment.paymentId;
      Order.deliveryCost = deliveryTotal;
      Order.total =  getTotal+deliveryTotal;
      Order.otp = Uuid().v4().split("-")[3];


      await Firestore.instance.runTransaction((Transaction t) async {

      });

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, "/order-confirm-page");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showDialogBox(response.code.toString() + ": " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (_WALLETS.contains(response.walletName)) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, "/order-confirm-page");
    }
  }

  void startPayment() {
    try {
      var options = {
        'key': 'rzp_test_UR3ON1Z6tddkOu',
        'amount': (getTotal + deliveryTotal) * 100,
        'name': 'lAUNDRO',
        'description': 'laundry service',
        'prefill': {
          'contact': '9123456789',
          'email': 'gaurav.kumar@example.com'
        },
        'external': {
          "wallets": _WALLETS,
        }
      };
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getData() async {
    _prefs = await SharedPreferences.getInstance();
    iron = _prefs.getString("iron") == null
        ? []
        : json.decode(_prefs.getString("iron"));
    wash = _prefs.getString("wash") == null
        ? []
        : json.decode(_prefs.getString("wash"));
    dryClean = _prefs.getString("dry-clean") == null
        ? []
        : json.decode(_prefs.getString("dry-clean"));

    var dryCleaningCost = 0;
    var washingCost = 0;
    var ironCost = 0;


    this.setState(() {
      items = [...wash, ...iron, ...dryClean];
    });
  }

  showBottom() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PaymentInfoModal(paymentHandler: startPayment);
        });
  }

  showDialogBox(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  child: Text("close"), onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  get getTotal {
    int total = 0;
    try {
      if (items.length > 0) {
        for (var i = 0; i < items.length; i++) {
          total += items[i]["qty"] * items[i]["price"];
        }
      }
    } catch (e) {
      print(e);
    }
    return total;
  }

  get deliveryTotal {
    int total = 0;
    int costTotal = getTotal;
    if (costTotal >= 30 && costTotal < 50) {
      for (var i = 0; i < items.length; i++) {
        total += items[i]["qty"] * 2;
      }
    } else if (costTotal >= 50 && costTotal <= 80) {
      for (var i = 0; i < items.length; i++) {
        total += items[i]["qty"] * 1;
      }
    }
    return total;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
                child: items.length == 0
                    ? Container(child: Center(child: Text("No Items")))
                    : Column(children: <Widget>[
                        Expanded(child: CartList(list: items)),
                        Divider(),
                        CostPanel(title: "Sub-Total", cost: getTotal),
                        CostPanel(
                            title: "Delivery Cost",
                            cost: deliveryTotal,
                            isFree: getTotal > 80),
                        CostPanel(
                            title: "Grand Total",
                            cost: getTotal + deliveryTotal),
                        Divider(),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Text("Proceed to payment",
                              style: TextStyle(fontSize: 16)),
                          color: getTotal < 30 ? Colors.red : Colors.green,
                          textColor: Colors.white,
                          onPressed: () => getTotal < 30
                              ? showDialogBox("Minimum cart value Rs.30")
                              : showBottom(),
                        )
                      ]))));
  }
}

class CostPanel extends StatelessWidget {
  final String title;
  final int cost;
  final bool isFree;

  CostPanel({this.title, this.cost, this.isFree = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(title, textAlign: TextAlign.left)),
            Text(isFree ? "Free" : "Rs." + cost.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(color: isFree ? Colors.green : Colors.black))
          ],
        ));
  }
}
