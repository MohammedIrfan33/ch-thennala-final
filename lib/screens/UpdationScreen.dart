import 'dart:io';

import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Updationscreen extends StatelessWidget {
  String url;
  Updationscreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 12),

              Image.asset("assets/StaticImg/footersplash.png", width: 200),

              Spacer(),

              Image.asset("assets/StaticImg/updategif.gif", height: 300),
              SizedBox(height: 48),
              Text(
                'Update Required',
                style: TextStyle(
                  color: const Color(0xFF159BFC),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 28),
              Text(
                'Please update our app for an \nimproved experience! This version is  \nno longer supported.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF253138),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  _launchURL(url);
                },
                child: Container(
                  height: 50,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [AppColors.primaryColor, AppColors.primaryColor2],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Update Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
