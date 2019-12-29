import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender { male, female }

class User {
  String uid;
  String displayName;
  DateTime dob;
  String email;
  String gender;
  String phoneNumber;
  String primaryAddress;
  String primaryAddressCity;
  String primaryAddressLine1;
  String primaryAddressLine2;
  String primaryAddressPincode;
  String primaryAddressState;
  Map orderHistory = {};

  User(
      {this.displayName,
      this.uid,
      this.dob,
      this.email,
      this.gender,
      this.phoneNumber,
      this.primaryAddress,
      this.primaryAddressCity,
      this.primaryAddressLine1,
      this.primaryAddressLine2,
      this.primaryAddressPincode,
      this.primaryAddressState,
      this.orderHistory});

  User.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    uid = json["uid"];
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    primaryAddress = json['primaryAddress'];
    primaryAddressCity = json['primaryAddressCity'];
    primaryAddressLine1 = json['primaryAddressLine1'];
    primaryAddressLine2 = json['primaryAddressLine2'];
    primaryAddressPincode = json['primaryAddressPincode'];
    primaryAddressState = json['primaryAddressState'];
    orderHistory = json["orderHistory"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['uid'] = this.uid;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['primaryAddress'] = this.primaryAddress;
    data['primaryAddressCity'] = this.primaryAddressCity;
    data['primaryAddressLine1'] = this.primaryAddressLine1;
    data['primaryAddressLine2'] = this.primaryAddressLine2;
    data['primaryAddressPincode'] = this.primaryAddressPincode;
    data['primaryAddressState'] = this.primaryAddressState;
    data['orderHistory'] = this.orderHistory;
    return data;
  }

  static Future<User> getPrefUser() async {
    final pref = await SharedPreferences.getInstance();
    final userJson = json.decode(pref.getString('user'));
    return User.fromJson(userJson);
  }

  static Future<bool> doesExists() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('user');
  }

  Future<bool> setPrefUser() async {
    final pref = await SharedPreferences.getInstance();
    final isUserSet = await pref.setString('user', json.encode(this.toJson()));
    return isUserSet;
  }

  Future<User> getUserFromFirebase(String uid) async {
    final fireStore = Firestore.instance;
    final fireStoreUser =
        await fireStore.collection("users").document(uid).get();
    return User.fromJson(fireStoreUser.data);
  }

  Future<void> setUserToFirebase(User user) async {
    final fireStore = Firestore.instance;
    final userRef = fireStore.collection("users").document();
    user.uid = userRef.documentID;

    await userRef.setData({...user.toJson(), "dob": user.dob.toString()});
  }

  Map<String, dynamic> getFilteredUser() {
    final userMap = {...this.toJson()};
    userMap.remove("dob");
    userMap.remove("displayName");
    userMap.remove("gender");
    userMap.remove("primaryAddressCity");
    userMap.remove("primaryAddressLine1");
    userMap.remove("primaryAddressLine2");
    userMap.remove("primaryAddressState");
    userMap.remove("orderHistory");
    return userMap;
  }
}
