class Order {
  String orderId;
  String instruction;
  String otp;
  String shopShopId;
  String shopName;
  double total;
  double deliveryCost;
  DateTime orderPlacedDateTime;
  DateTime deliveryDateTime;
  bool orderIsAccepted;
  bool orderIsPickedUp;
  bool orderIsDelivered;
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
      this.shopShopId,
      this.shopName,
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
    shopShopId = json['shopShopId'];
    shopName = json['shopName'];
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
    data['shopShopId'] = this.shopShopId;
    data['shopName'] = this.shopName;
    data['orderIsAccepted'] = this.orderIsAccepted;
    data['orderIsPickedUp'] = this.orderIsPickedUp;
    data['orderIsDelivered'] = this.orderIsDelivered;
    data['payment'] = this.payment;
    return data;
  }

  static createOrder(String razorPayId) async {}
}
