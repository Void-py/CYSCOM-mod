import 'package:flutter/material.dart';
import 'package:mod_appl/components/CustomDropDown.dart';

class Deptdropdown {
  static CustDropdownMenuItem getDeptDropDown(String dept_name) {
    return CustDropdownMenuItem(
        value: dept_name,
        child: Container(
          color: Colors.transparent,
          child: Text(dept_name,
              style: TextStyle(
                fontFamily: "Rubik",
                fontSize: 12,
                color: Colors.white,
              )),
        ));
  }
}
