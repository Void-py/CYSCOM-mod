import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mod_appl/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mod_appl/models/UserModel.dart';

class Databasecontroller {
  static FirebaseDatabase database_ = FirebaseDatabase.instance;
  static void AppendUserData({
    required String reg_no,
    required String dept,
    required String name,
    required String password,
    required String email,
    required String position,
    required Map<String, int> tasklist,
    required int points,
    required List<String> badges,
  }) async {
    DatabaseReference ref = FirebaseDatabase.instance.refFromURL(
        "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/");
    String formatted_email = email.replaceAll(".", ",");
    await ref.child('users').child(formatted_email).set(
        UserModel.getFormattedData(
            reg_no: reg_no,
            dept: dept,
            name: name,
            password: password,
            email: formatted_email,
            position: position,
            tasklist: tasklist,
            points: points,
            badges: badges));
  }

  static Future<Map<String, dynamic>> ReadUserData({required email}) async {
    String formatted_email = email.replaceAll(".", ",");
    final snapshot = await FirebaseDatabase.instance
        .refFromURL(
            "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .child("users/$formatted_email")
        .get();
    if (snapshot.exists) {
      return Map.from(snapshot.value as dynamic);
    } else {
      return {"NIL": "NIL"};
    }
  }

  static Future<bool> isAdmin({required email}) async {
    Map<String, dynamic> usr_data = {};
    await ReadUserData(email: email).then((onValue) {
      usr_data = onValue;
    });
    return usr_data["position"].toString().toUpperCase() != "MEMBER";
  }

  static Future<bool> userValidation(String user_email) async {
    final snapshot = await FirebaseDatabase.instance
        .refFromURL(
            "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .child("users/${user_email.replaceAll(".", ",")}")
        .get() as DataSnapshot;
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>> getLeaderBoard() async {
    final snapshot = await FirebaseDatabase.instance
        .refFromURL(
            "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .child("users")
        .get();

    if (snapshot.exists) {
      return Map.from(snapshot.value as dynamic);
    } else {
      return {"NIL": "NIL"};
    }
  }

  static void UpdateTaskList(
      String user_email, Map<String, dynamic> new_tasklist) async {
    final ref = FirebaseDatabase.instance
        .refFromURL(
            "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .child("users/${user_email.replaceAll(".", ",")}");
    await ref.update({
      "tasklist": new_tasklist,
    });
  }

  static void UpdateUserPoints(String user_email, int points) async {
    final ref = FirebaseDatabase.instance
        .refFromURL(
            "https://cyscom-mod-default-rtdb.asia-southeast1.firebasedatabase.app/")
        .child("users/${user_email.replaceAll(".", ",")}");
    await ref.update({
      "points": points,
    });
  }
}
