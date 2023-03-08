import 'package:flutter/material.dart';

import '../colors.dart';

InputBorder focusBorder() =>  OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff043369), width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ));

InputBorder errorBorder() =>  OutlineInputBorder(
    borderSide: BorderSide(color: deleteColor, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ));

InputBorder border() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide:  BorderSide(color: Color(0xff043369), width: 1.0),
);