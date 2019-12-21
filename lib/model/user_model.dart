enum Gender { male, female }

class User {
  static String email = '';
  static String displayName = '';
  static String uid = '';
  static String phone = '';
  static String primaryAddress = '';
  static String primaryAddressLine1 = '';
  static String primaryAddressLine2 = '';
  static String primaryAddressState = '';
  static String primaryAddressCity = '';

  static String pincode = '';
  static String gender = 'male';
  static DateTime dob;
  static List<Map<dynamic, dynamic>> orderHistory;
}
