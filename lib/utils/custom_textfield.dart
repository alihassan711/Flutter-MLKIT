import 'package:flutter/material.dart';

import '../constants/styles.dart';

class TextFormFieldCustom extends StatelessWidget {
  FormFieldValidator? valid;
  Icon? icon;
  TextEditingController? controller;
  String? labelText, hintText;
  double? txtWidth, txtHeight, circulor;

  TextFormFieldCustom(
      {Key? key,
        this.icon,
        this.valid,
        this.labelText,
        this.hintText,
        this.controller,
        this.txtWidth,
        this.txtHeight,
        this.circulor,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          focusedBorder: focusBorder(),
          border: border(),
          errorBorder: errorBorder(),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
