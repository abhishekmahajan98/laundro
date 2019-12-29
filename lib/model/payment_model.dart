import 'package:uuid/uuid.dart';

class Payment {
  String paymentId;
  String razorpayId;
  String paymentStatus;
  double amount;
  Map user;

  Payment(
      {this.paymentId,
      this.razorpayId,
      this.paymentStatus,
      this.amount,
      this.user});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    razorpayId = json['razorpayId'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['razorpayId'] = this.razorpayId;
    data['paymentStatus'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['user'] = this.user;
    return data;
  }

  void generatePaymentId() {
    this.paymentId = Uuid().v1().split("-")[4];
  }

  void setRazorpayId(String razorpayId) {
    this.razorpayId = razorpayId;
  }

  Map<String, dynamic> getFilteredPayment() {
    final paymentMap = {...this.toJson()};
    paymentMap.remove("razorpayId");
    paymentMap.remove("user");
    return paymentMap;
  }
}
