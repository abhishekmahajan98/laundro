import 'package:uuid/uuid.dart';

enum PaymentStatus { completed, inProgress, refunded, cancelled }
enum PaymentMode { card, wallet, onlineBanking, upi }

class Payment {
  String paymentId = Uuid().v4().split("-").sublist(0, 2).join();
  String razonPayId;
  String paymentStatus;
  String paymentMode;
  double amount;
  Map<dynamic, dynamic> userDetail = {"userId": null, "phone": null};
}
