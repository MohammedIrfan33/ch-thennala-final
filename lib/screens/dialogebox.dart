import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomAlert(BuildContext context,VoidCallback onConfirm,VoidCallback onCancle) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Color(0xFFFFFCDF), // Background color
        child: Padding(
          padding: const EdgeInsets.all(20), // Padding for spacing
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content
            children: [
              // Centered Text
              Text(
                'താങ്കൾ ആവശ്യമായ കിറ്റുകളുടെ\nഎണ്ണം തിരഞ്ഞെടുത്തിട്ടില്ല',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAF252B),
                  fontSize: 18,
                  fontFamily: 'Anek Malayalam',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 28), // Space between text and buttons

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Negative Button
                  Expanded(

                    child: GestureDetector(
                      onTap: () {
                        onCancle();
                      }, // Close alert
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),

                        height: 44,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Color(0xFFACACAC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:Text(
                          'ആവശ്യമുണ്ട്',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Anek Malayalam',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Positive Button
                  Expanded(

                    child: GestureDetector(
                      onTap: () {
                        // Add your action here

                        onConfirm();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        height: 44,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Color(0xFFAF252B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'ആവശ്യമില്ല ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Anek Malayalam',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), // S
            ],
          ),
        ),
      );
    },
  );
}
