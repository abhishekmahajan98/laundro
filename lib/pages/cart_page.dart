import 'package:flutter/material.dart';
import 'package:laundro/model/items_model.dart';
import 'package:laundro/model/order_model.dart';
import 'package:laundro/model/user_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../components/cart_list.dart';
import '../components/payment_info_modal.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List items = [];
  Razorpay _razorpay;
  double dryCleanCost = 0, washCost = 0, ironCost = 0;

  @override
  void initState() {
    super.initState();
    _getData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Order.create(response.paymentId, deliveryTotal);
    Navigator.pop(context);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => OrderConfirmPage(
    //               dryCleanId: orderDCRef.documentID,
    //               ironId: orderIRef.documentID,
    //               washId: orderWRef.documentID,
    //             )));
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    // TODO make failure payment
    showDialogBox(response.code.toString() + ": " + response.message);
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
      };
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getData() async {
    Items iron = await Items.getItemsPref("iron");
    Items wash = await Items.getItemsPref("wash");
    Items dryclean = await Items.getItemsPref("dryclean");

    this.setState(() {
      items = [
        ...wash
            .toJson()
            .keys
            .toList()
            .sublist(0, wash.toJson().keys.toList().length - 2)
            .map((item) {
          return {
            "title": item,
            "tag": wash.tag,
            "qty": wash.toJson()[item]["quantity"],
            "price": wash.toJson()[item]["price"]
          };
        }),
        ...iron
            .toJson()
            .keys
            .toList()
            .sublist(0, iron.toJson().keys.toList().length - 2)
            .map((item) {
          return {
            "title": item,
            "tag": iron.tag,
            "qty": iron.toJson()[item]["quantity"],
            "price": iron.toJson()[item]["price"]
          };
        }),
        ...dryclean
            .toJson()
            .keys
            .toList()
            .sublist(0, dryclean.toJson().keys.toList().length - 2)
            .map((item) {
          return {
            "title": item,
            "tag": dryclean.tag,
            "qty": dryclean.toJson()[item]["quantity"],
            "price": dryclean.toJson()[item]["price"]
          };
        })
      ];
    });
  }

  showBottom() async {
    User user = await User.getPrefUser();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PaymentInfoModal(paymentHandler: startPayment, user: user);
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
