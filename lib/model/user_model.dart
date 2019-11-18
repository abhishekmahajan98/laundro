enum Gender { male, female }

class User {
  String email;
  String uid;
  String phone;
  String address;
  int pincode;
  String gender;
  DateTime dob;
  List<String> couponList;
  List<Map<dynamic, dynamic>> orderHistory;
}
