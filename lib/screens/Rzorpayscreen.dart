import 'package:flutter/material.dart';
class RazorpayScreen extends StatefulWidget{
  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  PreferredSize get _appBar {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: Image.asset("assets/images/homeicon.png"),
                ),
              ),
              const Center(
                  child: Text(
                    'Items',
                    style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )),
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: Image.asset("assets/images/notiffiicon.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  void openCheckout() {
   //print(">>>>>>>>>>>>>>>>>>>>>>> 1233we4342");
    var options = {
      'key': 'rzp_live_sDaDA7vOG8q68F',
      'amount': 50000, // Amount in paise (e.g. 50000 paise = INR 500)
      'name': 'work mate',
      'description': 'Product Description',
      'prefill': {
        'contact': '8888888888',
        'email': 'example@razorpay.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
     //print(">>>>>>>>>>>>>>>>>>>>>>> vvvvvvvvvvvvvvvvvvvvvv");
    } catch (e) {
     //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    openCheckout();
    return Scaffold(
      appBar:_appBar ,
      body: SizedBox(),
    );

  }
}