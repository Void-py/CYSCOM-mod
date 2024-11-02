import 'package:flutter/material.dart';

class UserModel {

  static Map<String,dynamic> getFormattedData(
      {required reg_no,
      required dept,
      required name,
      required password,
      required email,
      required position,
      required tasklist,
      required points,
      required badges}) {
    return {
      "reg_no":reg_no,
      "dept":dept,
      "name":name,
      "password":password,
      "email":email,
      "position":position,
      "tasklist":tasklist,
      "points":points,
      "badges":badges,
    };
  }
}
