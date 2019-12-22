import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../components/cart_list.dart';
import '../components/payment_info_modal.dart';

final _WALLETS = ["paytm", "citrus", "amazonpay", "payzapp", "freecharge"];

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items = [];
  SharedPreferences _prefs;
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _getData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (response.paymentId != null) {
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
    var iron = _prefs.getString("iron") == null
        ? []
        : json.decode(_prefs.getString("iron"));
    var wash = _prefs.getString("wash") == null
        ? []
        : json.decode(_prefs.getString("wash"));
    var dryClean = _prefs.getString("dry-clean") == null
        ? []
        : json.decode(_prefs.getString("dry-clean"));

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
