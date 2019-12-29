class Payment {
  String paymentId;
  String razorPayId;
  String paymentStatus;
  String paymentMode;
  double amount;
  String userUserId;
  String phone;

  Payment(
      {this.paymentId,
      this.razorPayId,
      this.paymentStatus,
      this.paymentMode,
      this.amount,
      this.userUserId,
      this.phone});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    razorPayId = json['razorPayId'];
    paymentStatus = json['paymentStatus'];
    paymentMode = json['paymentMode'];
    amount = json['amount'];
    userUserId = json['userUserId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['razorPayId'] = this.razorPayId;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentMode'] = this.paymentMode;
    data['amount'] = this.amount;
    data['userUserId'] = this.userUserId;
    data['phone'] = this.phone;
    return data;
  }
}