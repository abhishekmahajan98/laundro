import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Items {
  Map bedSheetDouble;
  Map bedSheetSingle;
  Map jeansPants;
  Map pyjamaTrousers;
  Map saree;
  Map shorts;
  Map tShirtShirt;
  String tag;
  double total;

  Items(
      {this.bedSheetDouble,
      this.bedSheetSingle,
      this.jeansPants,
      this.pyjamaTrousers,
      this.saree,
      this.shorts,
      this.tShirtShirt,
      this.tag,
      this.total});

  Items.fromJson(Map<String, dynamic> json) {
    bedSheetDouble = json['bedSheet(Double)'];
    bedSheetSingle = json['bedSheet(Single)'];
    jeansPants = json['jeans/pants'];
    pyjamaTrousers = json['pyjama/trousers'];
    saree = json['saree'];
    shorts = json['shorts'];
    tShirtShirt = json['t-shirt/shirt'];
    tag = json['tag'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bedSheet(Double)'] = this.bedSheetDouble;
    data['bedSheet(Single)'] = this.bedSheetSingle;
    data['jeans/pants'] = this.jeansPants;
    data['pyjama/trousers'] = this.pyjamaTrousers;
    data['saree'] = this.saree;
    data['shorts'] = this.shorts;
    data['t-shirt/shirt'] = this.tShirtShirt;
    data['tag'] = this.tag;
    data["total"] = this.total;
    return data;
  }

  Future<bool> setItemPref() async {
    final pref = await SharedPreferences.getInstance();
    final isItemsSet =
        await pref.setString(this.tag, json.encode(this.toJson()));
    return isItemsSet;
  }

  static Future<Items> getItemsPref(String tag) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(tag)) {
      final itemsJson = json.decode(pref.getString(tag));
      return Items.fromJson(itemsJson);
    }
    return Items.fromJson({});
  }

  static Future<bool> getAndSetItemsFromFirebase() async {
    final fireStore = Firestore.instance;
    final fireStoreWashItems =
        await fireStore.collection("items").document("wash").get();
    final fireStoreIronItems =
        await fireStore.collection("items").document("iron").get();
    final fireStoreDryCleanItems =
        await fireStore.collection("items").document("dryclean").get();

    Items ironItems = Items.fromJson(fireStoreIronItems.data);
    Items washItems = Items.fromJson(fireStoreWashItems.data);
    Items dryCleanItems = Items.fromJson(fireStoreDryCleanItems.data);

    final isIronSet = await ironItems.setItemPref();
    final isWashSet = await washItems.setItemPref();
    final isDryCleanSet = await dryCleanItems.setItemPref();

    return isIronSet && isWashSet && isDryCleanSet;
  }

  Map<String, dynamic> getFilteredItems() {
    final itemsMap = {...this.toJson()};
    itemsMap.keys.forEach((key) {
      if (itemsMap[key].quantity == 0) itemsMap.remove(key);
    });
    return itemsMap;
  }
}
