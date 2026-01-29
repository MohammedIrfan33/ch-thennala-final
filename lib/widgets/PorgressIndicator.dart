

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class ProgressINdigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator( backgroundColor: Colors.black26,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.primaryColor2, //<-- SEE HERE
        ));
  }}