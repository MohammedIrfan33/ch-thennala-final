import 'dart:convert';
import 'package:http/http.dart' as http;



String closeChallenge = "0";


Future<void> loadCloseChallenge() async {
  try {
    final response = await http.get(
      Uri.parse("https://chcenterthennala.in/API/close_challenge.php"),
    );

 

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData["Status"] == true) {
        closeChallenge = jsonData["data"].toString();
       
    

      
      }
    }


  } catch (e) {
     closeChallenge = "0";
 
  }
}
