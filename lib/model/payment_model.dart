

enum PaymentStatus { completed, inProgress, refunded, cancelled }
enum PaymentMode { card, wallet, onlineBanking, upi }

class Payment {
static String paymentId ;
static String razonPayId;
static String paymentStatus;
static String paymentMode;
static double amount;
static Map<dynamic, dynamic> userDetail = {"userId": null, "phone": null};
}
