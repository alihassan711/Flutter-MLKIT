import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  String? text;
  Function()? onPressed;
  Color? color;
 // double? circularSize;
 // Color? txtColor;
  double? btnWidth, btnHeight;

  ElevatedBtn(
      {Key? key,
        this.text,
        this.onPressed,
        this.color,
      //  this.circularSize,
      //  this.txtColor,
      //  this.btnTxtSize,
        this.btnHeight,
        this.btnWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: btnWidth??80,
      // height: btnHeight??40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text!,
             // style: btnTextStyle(txtColor!),
            ),
          )),
    );
  }
}
