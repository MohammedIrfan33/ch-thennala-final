import 'dart:io';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Expiredscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 12),

              Image.asset("assets/StaticImg/footersplash.png", width: 200),

              Spacer(),

              Image.asset("assets/StaticImg/expired.png", height: 300),
              SizedBox(height: 18),
              Text(
                'Expired',
                style: TextStyle(
                  color: const Color(0xFF159BFC),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Your Application Has been expired \nPlease Contact Your Admin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF253138),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
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
