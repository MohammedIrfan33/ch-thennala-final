import 'package:flutter/material.dart';



List<String> datas=['Kinassery North','Puthiyapalam','Pallithayam','Puthiyara','Kommery','Mankav','Kinassery'];


class MyAppNew extends StatefulWidget {
  @override
  State<MyAppNew> createState() => _MyAppNewState();
}

class _MyAppNewState extends State<MyAppNew> {
  int? selected_index;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flexbox with Loop")),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10, // Like gap in flexbox
            runSpacing: 10, // Like row-gap in flexbox
            children: List.generate(datas.length, (index) =>
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () {

                      setState(() {
                        selected_index=index;
                      });





                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                     padding: EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                      decoration: ShapeDecoration(
                        color: index==selected_index?Colors.teal:Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF7F8181)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        datas[index],
                        style: TextStyle(
                          color: index==selected_index?Colors.white:Color(0xFF7F8281),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}


// Headersave(String orderId, String customerId,gateway val) async {
//   print("Headersave>>>>>>>>>>>");
//   bodyheadersave.isNull?null:bodyheadersave!["orderid"]=orderId;
//   bodyheadersave.isNull?null:bodyheadersave!["customerid"]=customerId;
//
//
//
//   final response = await post(Uri.parse(Savethehaderdatails), body: bodyheadersave);
//
//   if (response.statusCode == 200) {
//     if (response.body.isEmpty) {
//
//     } else {
//       Map<String, dynamic> parsedJson = jsonDecode(response.body);
//
//       if (parsedJson['Status'] == "True") {
//         headerID = parsedJson['data'].toString();
//
//
//
//
//         if(list.first.quantity==0){
//           if(val==gateway.razorpay){
//             openCheckout(orderId);
//           }else{
//             showthewebview(true);
//           }
//         }else{
//           titlesave(parsedJson['data'].toString(), orderId,val);
//         }
//
//       } else {
//
//       }
//     }
//   } else {
//
//     throw Exception('Failed to load data');
//   }
// }
//
// titlesave(String id, String orderId,gateway val) async {
//   print("titlesave>>>>>>>>");
//
//
//   int index = 0;
//   int lastIndex = 0;
//   for (var element in list) {
//     if (element.quantity != 0) {
//       lastIndex++;
//     }
//   }
//   lastIndex--;
//
//   for (var element in list) {
//     if (element.quantity != 0) {
//       final response = await post(Uri.parse(Savethetitle), body: {
//         'hdrid': id,
//         'item': element.productid,
//         'qty': element.quantity.toString(),
//         'rate': element.rate,
//         'amount': (element.quantity * double.parse(element.rate)).toString(),
//       });
//       // print(">>>>>>>>>>>>>>>>>>>>>>> titlesave  21>>>>>}");
//       // print(response.body);
//       if (response.statusCode == 200) {
//         if (response.body.isEmpty) {
//
//         } else {
//           Map<String, dynamic> parsedJson = jsonDecode(response.body);
//           if (parsedJson['Status'] == 'True') {
//             if (index == lastIndex) {
//               // print(">>>>>>>>>>>>>>>>>>>>>>> details  22${response.body}");
//               if(val==gateway.razorpay){
//                 openCheckout(orderId);
//               }else{
//                 showthewebview(true);
//               }
//
//
//             }
//           } else {
//
//           }
//         }
//       } else {
//
//         throw Exception('Failed to load data');
//       }
//       index++;
//     }
//   }
// }
