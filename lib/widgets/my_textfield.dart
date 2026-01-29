import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final double height;
  final double fontPading;
  final bool isNumber;
  final bool label;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.height,
      required this.fontPading,
      required this.isNumber,
        this.label=false
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: fontPading),
      child: SizedBox(
        height: height,
        child: TextField(
          textAlign: TextAlign.left,
          controller: controller,
          obscureText: obscureText,

            keyboardType:isNumber? TextInputType.number:TextInputType.text,
            inputFormatters: [
             isNumber? FilteringTextInputFormatter.digitsOnly:FilteringTextInputFormatter.singleLineFormatter,
            ],

          decoration: InputDecoration(
            label: Text(hintText,style: TextStyle(fontSize: 14, color: Colors.black54,)),

              // enabledBorder: const OutlineInputBorder(
              //   borderSide: BorderSide(color: Color(0xffE0EDFF),width:1),
              //     borderRadius: BorderRadius.all(Radius.circular(12))
              // ),
              // focusedBorder: const OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.primaryColor2,width: 2),
              //   borderRadius: BorderRadius.all(Radius.circular(12))
              // ),

              hintStyle:
              const TextStyle(fontSize: 16, color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Color(0xFFE0EDFF)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor2),
                borderRadius: BorderRadius.circular(10.0),
              ),



          ),
          style: const TextStyle(fontFamily: "Fmedium",
              fontSize: 16,
              height: 1.0, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
