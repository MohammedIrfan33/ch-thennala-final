import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/screens/Homepage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chcenterthennala/screens/homepage3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:unique_identifier/unique_identifier.dart';
import 'package:uuid/uuid.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import 'NewHomeScreen.dart';

class Screensplash extends StatefulWidget {
  const Screensplash({super.key});

  @override
  State<Screensplash> createState() => _ScreensplashState();
}

class _ScreensplashState extends State<Screensplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
    iOptions: _getIOSOptions(),
  );

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  Future<String?> getDeviceId() async {
    // Generate new ID if not stored
    String? newId = await getEnhancedHashedDeviceId();
    print("serial function return number ${newId}");

    //  await _storage.write(key: _storageKey, value: newId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppData.volunteerId = prefs.getString("id") ?? null;
    AppData.uniqueid = newId ?? "";

    return newId;
  }

  // Future<String?> initUniqueIdentifierState() async {
  //   String? identifier;
  //   try {
  //     identifier = await UniqueIdentifier.serial;
  //   } on PlatformException {
  //     identifier = 'Failed to get Unique Identifier';
  //   }
  //   if (!mounted) return "";
  //
  //   // SharedPreferences prefs  = await SharedPreferences.getInstance();
  //   // AppData.volunteerId=prefs.getString("id")??null;
  //   // AppData.uniqueid=identifier??"";
  //
  //   return identifier;
  // }

  Future<String> getEnhancedHashedDeviceId() async {
    String? storedValue = await storage.read(key: "uniqueid") ?? "";
    if (storedValue.isNotEmpty) {
      print(">>>>>>>>>>>>storedValue=====${storedValue}");
      return storedValue;
    }

    final deviceInfo = DeviceInfoPlugin();
    List<String> values = [];

    if (Platform.isAndroid) {
      final result = await callNativeMethod();

      print(">>>>>>>>>>>>reslut=====${result}");
      final android = await deviceInfo.androidInfo;

      values = [android.id, result];
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;

      values = [
        ios.identifierForVendor ??
            '', // Persistent across installs (unless device is reset)
        ios.name,
        ios.systemName,
        ios.systemVersion,
        ios.model,
        ios.localizedModel,
        ios.utsname.machine,
        ios.utsname.nodename,
        ios.utsname.release,
        ios.utsname.sysname,
        ios.utsname.version,
      ];
    }

    final raw = values.join('|');
    final hash = sha256.convert(utf8.encode(raw));
    await storage.write(key: "uniqueid", value: hash.toString());
    print(">>>>>>>>>>>>hash=====${hash.toString()}");
    return hash.toString(); // Return the final hashed device ID
  }

  // Future<String> _getHardwareId() async {
  //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     print("serial number ${ androidInfo.serialNumber}");
  //
  //
  //     print("androidid=${androidInfo.id}");
  //     print("androidsearialnumber=${androidInfo.serialNumber}");
  //     print("androidmanufacturer=${androidInfo.manufacturer}");
  //     print("androiddevice=${androidInfo.device}");
  //     print("androidboard=${androidInfo.board}");
  //     print("androidversionbos=${androidInfo.version.baseOS}");
  //     print("androidcodename=${androidInfo.version.codename}");
  //     print("androidincremental=${androidInfo.version.incremental}");
  //     print("androidsdkInt=${androidInfo.version.sdkInt.toString()}");
  //
  //
  //
  //
  //     return androidInfo.id; // Unique hardware ID (changes only with factory reset)
  //
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     return iosInfo.identifierForVendor ?? Uuid().v4(); // UUID (persists until factory reset)
  //   }
  //   return Uuid().v4(); // Fallback in case of unknown platform
  //   //  if(GetPlatform.isAndroid){
  //   //    String uuid_s=await _loadOrGenerateUUID();
  //   //    print("Uuid >>>>>>>>>>>>>>>>>${uuid_s}");
  //   //    return uuid_s;
  //   //  }else if (GetPlatform.isIOS){
  //   //    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   //    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //   //    return Uuid().v4();
  //   //
  //   //  }return "";
  //
  //
  //
  //
  // }

  // Future<String> _loadOrGenerateUUID() async {
  //
  //   String? storedValue = await storage.read(key:  "Androidid");
  //   if(storedValue==null){
  //
  //     print("storedValue==null");
  //
  //
  //     final file = await _getUUIDFile();
  //
  //     if (await file.exists()) {
  //
  //
  //       final fileUUID = await file.readAsString();
  //
  //       print("storedValue==null file =yes==${fileUUID}");
  //       await storage.write(key: "Androidid", value: fileUUID);
  //       return fileUUID;
  //
  //
  //     } else {
  //
  //
  //
  //
  //       final newUUID = Uuid().v4();
  //       await storage.write(key: "Androidid", value: newUUID.toString());
  //       await file.writeAsString(newUUID);
  //
  //       print("storedValue==null file =no==${newUUID}");
  //
  //
  //
  //       return newUUID;
  //     }
  //   }else{
  //
  //
  //     final file = await _getUUIDFile();
  //
  //     if (await file.exists()) {
  //
  //       final fileUUID = await file.readAsString();
  //
  //       print("storedValue==yes file =yes==${fileUUID}");
  //       if(fileUUID==storedValue){
  //        print("Match....");
  //
  //         print('UUIDs match. Continuing...');
  //         return fileUUID;
  //       }else{
  //
  //
  //         print("un Match....");
  //
  //         await storage.write(key: "Androidid", value: fileUUID.toString());
  //
  //
  //         print('New UUID generated and saved. Continuing...');
  //         final response = await http.post(Uri.parse(ChangeUUId),body: {
  //           "Transid_old":fileUUID,
  //           "Transid_new":storedValue,
  //         });
  //
  //         if (response.statusCode == 200) {
  //           Map<String, dynamic> data = json.decode(response.body);
  //           if(data['Status'].toString().toLowerCase()=='true'){
  //
  //           }
  //         } else {
  //           throw Exception('Failed to load items');
  //         }
  //
  //
  //
  //
  //         return storedValue;
  //       }
  //
  //
  //     } else {
  //
  //       await file.writeAsString(storedValue);
  //       print("storedValue==yes file =no==${storedValue}");
  //       print('New UUID generated and saved. Continuing...');
  //
  //       return storedValue;
  //     }
  //
  //   }
  //
  // }
  // Future<File> _getUUIDFile() async {
  //
  //
  //   final filePath = '/storage/emulated/0/Downloads';
  //
  //
  //     final file = File('${filePath}/uuid.txt');
  //
  //
  //
  //   if (file != null) {
  //     print("file path 1>>>>>${file.path}");
  //     return file;
  //   }else{
  //     final directory2=await getApplicationSupportDirectory();
  //     final file = File('${directory2?.path}/uuid.txt');
  //     print("file path2 >>>>>${file.path}");
  //     return file;
  //   }
  //
  //
  // }

  gotoHomepage() {
    //print(">>>>>>uniqueid=$uniqueid");
    Timer(const Duration(seconds: 2), () => Get.off(Homepage3()));
  }

  Future<void> fetchDistrictapi() async {
    AppData.DistrictList =
        '{"Status":"true","data":[{"id":"1","name":"Malappuram"}]}';
    // final response = await http.get(Uri.parse(DistrictApi));
    //
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> data = json.decode(response.body);
    //   if(data['Status'].toString().toLowerCase()=='true'){
    //     AppData.DistrictList=response.body;
    //   }
    // } else {
    //   throw Exception('Failed to load items');
    // }
    return;
  }

  Future<void> fetchAssemblyapi() async {
    var _body = [
      {"id": "9", "name": "Kondotty", "districtid": "1"},
      {"id": "16", "name": "Kottakkal", "districtid": "1"},
      {"id": "1", "name": "Vallikkunnu", "districtid": "1"},
      {"id": "10", "name": "Vengara", "districtid": "1"},
      {"id": "15", "name": "Tirurangadi", "districtid": "1"},
    ];
    AppData.Assembly = '{"Status":"true","data":${json.encode(_body)}}';

    // AppData.Assembly='{"Status":"true","data":[{"id":"26","name":"Adoor","districtid":"3"},'
    //     '{"id":"31","name":"Alappuzha","districtid":"4"},'
    //     '{"id":"81","name":"Alathur","districtid":"9"},'
    //     '{"id":"54","name":"Aluva","districtid":"7"},'
    //     '{"id":"32","name":"Ambalappuzha","districtid":"4"},'
    //     '{"id":"55","name":"Angamaly","districtid":"7"},'
    //     '{"id":"27","name":"Aranmula","districtid":"3"},'
    //     '{"id":"33","name":"Aroor","districtid":"4"},'
    //     '{"id":"1","name":"Aruvikkara","districtid":"1"},'
    //     '{"id":"2","name":"Attingal","districtid":"1"},'
    //     '{"id":"125","name":"Azhikode","districtid":"13"},'
    //     '{"id":"109","name":"Balussery","districtid":"11"},'
    //     '{"id":"110","name":"Beypore","districtid":"11"},'
    //     '{"id":"15","name":"Chadayamangalam","districtid":"2"},'
    //     '{"id":"68","name":"Chalakudy","districtid":"8"},'
    //     '{"id":"40","name":"Changanassery","districtid":"5"},'
    //     '{"id":"16","name":"Chathannoor","districtid":"2"},'
    //     '{"id":"17","name":"Chavara","districtid":"2"},'
    //     '{"id":"69","name":"Chelakkara","districtid":"8"},'
    //     '{"id":"34","name":"Chengannur","districtid":"4"},'
    //     '{"id":"35","name":"Cherthala","districtid":"4"},'
    //     '{"id":"3","name":"Chirayinkeezhu","districtid":"1"},'
    //     '{"id":"82","name":"Chittur","districtid":"9"},'
    //     '{"id":"49","name":"Devikulam","districtid":"6"},'
    //     '{"id":"126","name":"Dharmadom","districtid":"13"},'
    //     '{"id":"111","name":"Elathur","districtid":"11"},'
    //     '{"id":"93","name":"Eranad","districtid":"10"},'
    //     '{"id":"18","name":"Eravipuram","districtid":"2"},'
    //     '{"id":"56","name":"Ernakulam","districtid":"7"},'
    //     '{"id":"41","name":"Ettumanoor","districtid":"5"},'
    //     '{"id":"70","name":"Guruvayur","districtid":"8"},'
    //     '{"id":"36","name":"Haripad","districtid":"4"},'
    //     '{"id":"50","name":"Idukki","districtid":"6"},'
    //     '{"id":"127","name":"Irikkur","districtid":"13"},'
    //     '{"id":"71","name":"Irinjalakuda","districtid":"8"},'
    //     '{"id":"42","name":"Kaduthuruthy","districtid":"5"},'
    //     '{"id":"72","name":"Kaipamangalam","districtid":"8"},'
    //     '{"id":"57","name":"Kalamassery","districtid":"7"},'
    //     '{"id":"128","name":"Kalliasseri","districtid":"13"},'
    //     '{"id":"122","name":"Kalpetta","districtid":"12"},'
    //     '{"id":"136","name":"Kanhangad","districtid":"14"},'
    //     '{"id":"43","name":"Kanjirappally","districtid":"5"},'
    //     '{"id":"129","name":"Kannur","districtid":"13"},'
    //     '{"id":"19","name":"Karunagapally","districtid":"2"},'
    //     '{"id":"137","name":"Kasaragod","districtid":"14"},'
    //     '{"id":"4","name":"Kattakkada","districtid":"1"},'
    //     '{"id":"37","name":"Kayamkulam","districtid":"4"},'
    //     '{"id":"5","name":"Kazhakootam","districtid":"1"},'
    //     '{"id":"58","name":"Kochi","districtid":"7"},'
    //     '{"id":"73","name":"Kodungallur","districtid":"8"},'
    //     '{"id":"112","name":"Koduvally","districtid":"11"},'
    //     '{"id":"20","name":"Kollam","districtid":"2"},'
    //     '{"id":"94","name":"Kondotty","districtid":"10"},'
    //     '{"id":"83","name":"Kongad","districtid":"9"},'
    //     '{"id":"28","name":"Konni","districtid":"3"},'
    //     '{"id":"59","name":"Kothamangalam","districtid":"7"},'
    //     '{"id":"95","name":"Kottakkal","districtid":"10"},'
    //     '{"id":"21","name":"Kottarakkara","districtid":"2"},{"id":"44","name":"Kottayam","districtid":"5"},{"id":"6","name":"Kovalam","districtid":"1"},{"id":"113","name":"Koyilandy","districtid":"11"},{"id":"114","name":"Kozhikode North","districtid":"11"},{"id":"115","name":"Kozhikode South","districtid":"11"},{"id":"22","name":"Kundara","districtid":"2"},{"id":"116","name":"Kunnamangalam","districtid":"11"},{"id":"74","name":"Kunnamkulam","districtid":"8"},{"id":"60","name":"Kunnathunad","districtid":"7"},{"id":"23","name":"Kunnathur","districtid":"2"},{"id":"130","name":"Kuthuparamba","districtid":"13"},{"id":"38","name":"Kuttanad","districtid":"4"},{"id":"117","name":"Kuttiady","districtid":"11"},{"id":"84","name":"Malampuzha","districtid":"9"},{"id":"96","name":"Malappuram","districtid":"10"},{"id":"75","name":"Manalur","districtid":"8"},{"id":"123","name":"Mananthavady","districtid":"12"},{"id":"97","name":"Manjeri","districtid":"10"},{"id":"138","name":"Manjeshwaram","districtid":"14"},{"id":"98","name":"Mankada","districtid":"10"},{"id":"85","name":"Mannarkkad","districtid":"9"},{"id":"131","name":"Mattanur","districtid":"13"},{"id":"39","name":"Mavelikara","districtid":"4"},{"id":"61","name":"Muvattupuzha","districtid":"7"},{"id":"118","name":"Nadapuram","districtid":"11"},{"id":"76","name":"Nattika","districtid":"8"},{"id":"7","name":"Nedumangad","districtid":"1"},{"id":"8","name":"Nemom","districtid":"1"},{"id":"86","name":"Nenmara","districtid":"9"},{"id":"9","name":"Neyyattinkara","districtid":"1"},{"id":"99","name":"Nilambur","districtid":"10"},{"id":"77","name":"Ollur","districtid":"8"},{"id":"87","name":"Ottapalam","districtid":"9"},{"id":"45","name":"Pala","districtid":"5"},{"id":"88","name":"Palakkad","districtid":"9"},{"id":"10","name":"Parassala","districtid":"1"},{"id":"62","name":"Paravur","districtid":"7"},{"id":"24","name":"Pathanapuram","districtid":"2"},{"id":"89","name":"Pattambi","districtid":"9"},{"id":"132","name":"Payyanur","districtid":"13"},{"id":"51","name":"Peerumade","districtid":"6"},{"id":"119","name":"Perambra","districtid":"11"},{"id":"133","name":"Peravoor","districtid":"13"},{"id":"100","name":"Perinthalmanna","districtid":"10"},{"id":"63","name":"Perumbavoor","districtid":"7"},{"id":"64","name":"Piravom","districtid":"7"},{"id":"101","name":"Ponnani","districtid":"10"},{"id":"46","name":"Poonjar","districtid":"5"},{"id":"25","name":"Punalur","districtid":"2"},{"id":"78","name":"Puthukkad","districtid":"8"},{"id":"47","name":"Puthuppally","districtid":"5"},{"id":"29","name":"Ranni","districtid":"3"},{"id":"90","name":"Shornur","districtid":"9"},{"id":"124","name":"Sulthan Bathery","districtid":"12"},{"id":"134","name":"Taliparamba","districtid":"13"},{"id":"102","name":"Tanur","districtid":"10"},{"id":"91","name":"Tarur","districtid":"9"},{"id":"135","name":"Thalassery","districtid":"13"},{"id":"103","name":"Thavanur","districtid":"10"},{"id":"30","name":"Thiruvalla","districtid":"3"},{"id":"120","name":"Thiruvambady","districtid":"11"},{"id":"11","name":"Thiruvananthapuram","districtid":"1"},{"id":"52","name":"Thodupuzha","districtid":"6"},{"id":"139","name":"Thrikaripur","districtid":"14"},{"id":"65","name":"Thrikkakara","districtid":"7"},{"id":"66","name":"Thrippunithura","districtid":"7"},{"id":"79","name":"Thrissur","districtid":"8"},{"id":"92","name":"Thrithala","districtid":"9"},{"id":"104","name":"Tirur","districtid":"10"},{"id":"105","name":"Tirurangadi","districtid":"10"},{"id":"140","name":"Udma","districtid":"14"},'
    //     '{"id":"53","name":"Udumbanchola","districtid":"6"},{"id":"121","name":"Vadakara","districtid":"11"},{"id":"48","name":"Vaikom","districtid":"5"},{"id":"106","name":"Vallikkunnu","districtid":"10"},{"id":"12","name":"Vamanapuram","districtid":"1"},{"id":"13","name":"Varkala","districtid":"1"},{"id":"14","name":"Vattiyoorkavu","districtid":"1"},{"id":"107","name":"Vengara","districtid":"10"},{"id":"67","name":"Vypin","districtid":"7"},{"id":"80","name":"Wadakkanchery","districtid":"8"},{"id":"108","name":"Wandoor","districtid":"10"}]}';

    //final response = await http.get(Uri.parse(newAssemblyApi));
    //
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> data = json.decode(response.body);
    //   if(data['Status'].toString().toLowerCase()=='true'){
    //     AppData.Assembly=response.body;
    //   }
    // } else {
    //   throw Exception('Failed to load items');
    // }
    return;
  }

  Future<void> fetchPanchaythapi() async {
    var pachaythBody = [
    
      {"id": "1", "assemblyid": "1", "name": "THENNALA"},
      {"id": "2", "assemblyid": "1", "name": "OTHER"},
      
    ];

    // var pachaythBody = [
    //   {"id": "1", "assemblyid": "10", "name": "Abdu Rahiman Nagar"},
    //   {"id": "112", "assemblyid": "9", "name": "Cheekode"},
    //   {"id": "11", "assemblyid": "1", "name": "Chelembra"},
    //   {"id": "111", "assemblyid": "9", "name": "Cherukavu"},
    //   {"id": "120", "assemblyid": "15", "name": "Edarikkode"},
    //   {"id": "27", "assemblyid": "10", "name": "Kannamangalam"},
    //   {"id": "34", "assemblyid": "9", "name": "Kondotty Muncipality"},
    //   {"id": "36", "assemblyid": "16", "name": "Kottakkal"},
    //   {"id": "122", "assemblyid": "16", "name": "Kottakkal Muncipality "},
    //   {"id": "113", "assemblyid": "9", "name": "Muthuvallur"},
    //   {"id": "49", "assemblyid": "1", "name": "Moonniyur"},
    //   {"id": "118", "assemblyid": "15", "name": "Nannambra"},
    //   {"id": "61", "assemblyid": "1", "name": "Pallikkal"},
    //   {"id": "117", "assemblyid": "15", "name": "Parappanagadi Muncipality"},
    //   {"id": "115", "assemblyid": "10", "name": "Parappur"},
    //   {"id": "121", "assemblyid": "15", "name": "Perumanna klari"},
    //   {"id": "68", "assemblyid": "1", "name": "Peruvallur"},
    //   {"id": "114", "assemblyid": "10", "name": "Oorakam"},
    //   {"id": "116", "assemblyid": "10", "name": "Othukkunagal"},
    //   {"id": "110", "assemblyid": "9", "name": "Pulikkal "},
    //   {"id": "85", "assemblyid": "1", "name": "Thenhipalam"},
    //   {"id": "119", "assemblyid": "15", "name": "Thennala"},
    //   {"id": "93", "assemblyid": "15", "name": "Tirurangadi muncipality"},
    //   {"id": "103", "assemblyid": "10", "name": "Vengara"},
    //   {"id": "109", "assemblyid": "9", "name": "Vazhakkad"},
    //   {"id": "108", "assemblyid": "9", "name": "Vazhayur "},
    //   {"id": "97", "assemblyid": "1", "name": "Vallikkunnu"},
    // ];

    AppData.Panchayt = '{"Status":"true","data":${json.encode(pachaythBody)}}';

    // AppData.Panchayt='{"Status":"true","data":[{"id":"379","name":"Abdu Rahiman Nagar","assemblyid":"107"},'
    //     '{"id":"576","name":"Adat","assemblyid":"80"},'
    //     '{"id":"755","name":"Adichanalloor","assemblyid":"16"},'
    //     '{"id":"1026","name":"Adimali","assemblyid":"49"},'
    //     '{"id":"940","name":"Adoor","assemblyid":"26"},'
    //     '{"id":"426","name":"Agali","assemblyid":"85"},'
    //     '{"id":"41","name":"Aikaranad","assemblyid":"60"},'
    //     '{"id":"168","name":"Ajanur","assemblyid":"136"},'
    //     '{"id":"993","name":"Akalakunnam","assemblyid":"47"},'
    //     '{"id":"418","name":"Akathethara","assemblyid":"84"},'
    //     '{"id":"895","name":"Ala","assemblyid":"34"},'
    //     '{"id":"1048","name":"Alacode","assemblyid":"52"},'
    //     '{"id":"563","name":"Alagappanagar","assemblyid":"78"},'
    //     '{"id":"118","name":"Alakode","assemblyid":"127"},'
    //     '{"id":"342","name":"Alamcode","assemblyid":"101"},{"id":"427","name":"Alanallur","assemblyid":"85"},{"id":"23","name":"Alangad","assemblyid":"57"},{"id":"772","name":"Alappad","assemblyid":"19"},{"id":"843","name":"Alappuzha","assemblyid":"31"},{"id":"393","name":"Alathur","assemblyid":"81"},{"id":"745","name":"Alayamon","assemblyid":"15"},{"id":"335","name":"Aliparamba","assemblyid":"100"},{"id":"505","name":"Alur","assemblyid":"71"},{"id":"1","name":"Aluva","assemblyid":"54"},{"id":"326","name":"Amarambalam","assemblyid":"99"},{"id":"435","name":"Ambalapara","assemblyid":"87"},{"id":"850","name":"Ambalappuzha North","assemblyid":"32"},{"id":"851","name":"Ambalappuzha South","assemblyid":"32"},{"id":"602","name":"Ambalavayal","assemblyid":"124"},{"id":"77","name":"Amballoor","assemblyid":"64"},{"id":"710","name":"Amboori","assemblyid":"10"},{"id":"728","name":"Anad","assemblyid":"12"},{"id":"470","name":"Anakkara","assemblyid":"92"},{"id":"311","name":"Anakkayam","assemblyid":"96"},{"id":"455","name":"Ananganadi","assemblyid":"90"},{"id":"818","name":"Anchal","assemblyid":"25"},{"id":"666","name":"Anchuthengu","assemblyid":"3"},{"id":"698","name":"Andoorkonam","assemblyid":"7"},{"id":"319","name":"Angadippuram","assemblyid":"98"},{"id":"9","name":"Angamaly","assemblyid":"55"},{"id":"912","name":"Anicadu","assemblyid":"30"},{"id":"107","name":"Anjarakandy","assemblyid":"126"},{"id":"523","name":"Annamanada","assemblyid":"73"},{"id":"546","name":"Anthikkad","assemblyid":"76"},{"id":"153","name":"Anthoor","assemblyid":"134"},{"id":"1060","name":"Arakkulam","assemblyid":"50"},{"id":"50","name":"Arakuzha","assemblyid":"61"},{"id":"143","name":"Aralam","assemblyid":"133"},{"id":"1080","name":"Aramnula","assemblyid":"27"},{"id":"868","name":"Arattupuzha","assemblyid":"36"},{"id":"632","name":"Areacode","assemblyid":"93"},{"id":"272","name":"Arikkulam","assemblyid":"119"},{"id":"536","name":"Arimpur","assemblyid":"75"},{"id":"819","name":"Ariyankavu","assemblyid":"25"},{"id":"825","name":"Arookutty","assemblyid":"33"},{"id":"826","name":"Aroor","assemblyid":"33"},{"id":"984","name":"Arpookara","assemblyid":"41"},{"id":"929","name":"Aruvappulam","assemblyid":"28"},{"id":"648","name":"Aruvikkara","assemblyid":"1"},{"id":"845","name":"Aryad","assemblyid":"31"},{"id":"649","name":"Aryanadu","assemblyid":"1"},{"id":"711","name":"Aryancode","assemblyid":"10"},{"id":"70","name":"Asamannoor","assemblyid":"63"},{"id":"361","name":"Athavanad","assemblyid":"104"},{"id":"985","name":"Athirampuzha","assemblyid":"41"},{"id":"479","name":"Athirappilly","assemblyid":"68"},{"id":"705","name":"Athiyannur","assemblyid":"9"},{"id":"208","name":"Atholi","assemblyid":"109"},{"id":"656","name":"Attingal","assemblyid":"2"},{"id":"577","name":"Avanur","assemblyid":"80"},{"id":"547","name":"Avinissery","assemblyid":"76"},{"id":"51","name":"Avoly","assemblyid":"61"},{"id":"254","name":"Ayancheri","assemblyid":"117"},{"id":"994","name":"Ayarkunnam","assemblyid":"47"},{"id":"52","name":"Ayavana","assemblyid":"61"},{"id":"645","name":"Ayiloor","assemblyid":"86"},{"id":"921","name":"Ayiroor","assemblyid":"29"},{"id":"983","name":"Aymanam","assemblyid":"41"},{"id":"10","name":"Ayyampuzha","assemblyid":"55"},{"id":"144","name":"Ayyankunnu","assemblyid":"133"},{"id":"1070","name":"Ayyappancoil","assemblyid":"51"},{"id":"101","name":"Azhikode","assemblyid":"125"},{"id":"290","name":"Azhiyur","assemblyid":"121"},{"id":"667","name":"Azhoor","assemblyid":"3"},{"id":"176","name":"Badiadka","assemblyid":"137"},{"id":"169","name":"Balal","assemblyid":"136"},{"id":"687","name":"Balaramapuram","assemblyid":"6"},{"id":"209","name":"Balusseri","assemblyid":"109"},{"id":"200","name":"Bedadka","assemblyid":"140"},{"id":"177","name":"Bellur","assemblyid":"137"},{"id":"950","name":"Bharananganam","assemblyid":"45"},{"id":"884","name":"Bharanikkavu","assemblyid":"37"},{"id":"1035","name":"Bisonvalley","assemblyid":"49"},{"id":"896","name":"Budhanoor","assemblyid":"34"},{"id":"746","name":"Chadayamangalam","assemblyid":"15"},{"id":"273","name":"Chakkittapara","assemblyid":"119"},{"id":"1071","name":"Chakkupallam","assemblyid":"51"},{"id":"478","name":"Chalakkudy","assemblyid":"68"},{"id":"456","name":"Chalavara","assemblyid":"90"},{"id":"471","name":"Chalissery","assemblyid":"92"},{"id":"631","name":"Chaliyar","assemblyid":"93"},{"id":"855","name":"Champakkulam","assemblyid":"38"},{"id":"1001","name":"Changanassery","assemblyid":"40"},{"id":"274","name":"Changaroth","assemblyid":"119"},{"id":"154","name":"Chapparapadavu","assemblyid":"134"},{"id":"248","name":"Chathamangalam","assemblyid":"116"},{"id":"756","name":"Chathannoor","assemblyid":"16"},{"id":"495","name":"Chavakkad","assemblyid":"70"},{"id":"763","name":"Chavara","assemblyid":"17"},{"id":"548","name":"Chazhoor","assemblyid":"76"},{"id":"294","name":"Cheacode","assemblyid":"94"},{"id":"262","name":"Chekkiad","assemblyid":"118"},{"id":"486","name":"Chelakkara","assemblyid":"69"},{"id":"221","name":"Chelannur","assemblyid":"111"},{"id":"373","name":"Chelembra","assemblyid":"106"},{"id":"31","name":"Chellanam","assemblyid":"58"},{"id":"237","name":"Chemancheri","assemblyid":"113"},{"id":"108","name":"Chembilode","assemblyid":"126"},{"id":"735","name":"Chemmaruthy","assemblyid":"13"},{"id":"201","name":"Chemnad","assemblyid":"140"},{"id":"974","name":"Chempu","assemblyid":"48"},{"id":"62","name":"Chendamangalam","assemblyid":"62"},{"id":"178","name":"Chengala","assemblyid":"137"},{"id":"115","name":"Chengalayi","assemblyid":"127"},{"id":"2","name":"Chengamanad","assemblyid":"54"},{"id":"894","name":"Chengannur","assemblyid":"34"},{"id":"238","name":"Chengottukavu","assemblyid":"113"},{"id":"706","name":"Chenkal","assemblyid":"9"},{"id":"827","name":"Chennam-Pallippuram","assemblyid":"33"},{"id":"1081","name":"Chenneerkara","assemblyid":"27"},{"id":"904","name":"Chennithala-Thriperumthura","assemblyid":"34"},{"id":"869","name":"Cheppad","assemblyid":"36"},{"id":"18","name":"Cheranalloor","assemblyid":"56"},{"id":"347","name":"Cheriyamundam","assemblyid":"102"},{"id":"897","name":"Cheriyanad","assemblyid":"34"},{"id":"549","name":"Cherpu","assemblyid":"76"},{"id":"457","name":"Cherpulasserry","assemblyid":"90"},{"id":"835","name":"Cherthala","assemblyid":"35"},{"id":"836","name":"Cherthala South","assemblyid":"35"},{"id":"295","name":"Cherukavu","assemblyid":"94"},{"id":"926","name":"Cherukole","assemblyid":"29"},{"id":"124","name":"Cherukunnu","assemblyid":"128"},{"id":"663","name":"Cherunniyoor","assemblyid":"2"},{"id":"625","name":"Cherupuzha","assemblyid":"132"},{"id":"870","name":"Cheruthana","assemblyid":"36"},{"id":"125","name":"Cheruthazham","assemblyid":"128"},{"id":"275","name":"Cheruvannur","assemblyid":"119"},{"id":"191","name":"Cheruvathur","assemblyid":"139"},{"id":"885","name":"Chettikulangara","assemblyid":"37"},{"id":"871","name":"Chingoli","assemblyid":"36"},{"id":"1036","name":"Chinnakanal","assemblyid":"49"},{"id":"1007","name":"Chirakkadavu","assemblyid":"43"},{"id":"102","name":"Chirakkal","assemblyid":"125"},{"id":"754","name":"Chirakkara","assemblyid":"16"},{"id":"668","name":"Chirayinkeezhu","assemblyid":"3"},{"id":"747","name":"Chithara","assemblyid":"15"},{"id":"938","name":"Chittar","assemblyid":"28"},{"id":"616","name":"Chittariparamba","assemblyid":"131"},{"id":"63","name":"Chittattukara","assemblyid":"62"},{"id":"400","name":"Chittur-Thathamangalam","assemblyid":"82"},{"id":"162","name":"Chockli","assemblyid":"135"},{"id":"385","name":"Chokkad","assemblyid":"108"},{"id":"538","name":"Choondal","assemblyid":"75"},{"id":"3","name":"Choornikkara","assemblyid":"54"},{"id":"291","name":"Chorode","assemblyid":"121"},{"id":"79","name":"Chottanikkara","assemblyid":"64"},{"id":"529","name":"Chowannur","assemblyid":"74"},{"id":"887","name":"Chunakkara","assemblyid":"39"},{"id":"327","name":"Chungathara","assemblyid":"99"},{"id":"773","name":"Clappana","assemblyid":"19"},{"id":"19","name":"Cochin Corporation","assemblyid":"56"},{"id":"202","name":"Delampady","assemblyid":"140"},{"id":"487","name":"Desamangalam","assemblyid":"69"},{"id":"880","name":"Devikulangara","assemblyid":"37"},{"id":"112","name":"Dharmadam","assemblyid":"126"},{"id":"192","name":"East Eleri","assemblyid":"139"},{"id":"799","name":"East Kallada","assemblyid":"23"},{"id":"263","name":"Edacheri","assemblyid":"118"},{"id":"328","name":"Edakkara","assemblyid":"99"},{"id":"78","name":"Edakkattuvayal","assemblyid":"64"},{"id":"1027","name":"Edamalakkudy","assemblyid":"49"},{"id":"820","name":"Edamulakkal","assemblyid":"25"},{"id":"353","name":"Edappal","assemblyid":"103"},{"id":"317","name":"Edappatta","assemblyid":"97"},{"id":"367","name":"Edarikode","assemblyid":"105"},{"id":"4","name":"Edathala","assemblyid":"54"},{"id":"514","name":"Edathiruthy","assemblyid":"72"},{"id":"856","name":"Edathua","assemblyid":"38"},{"id":"736","name":"Edava","assemblyid":"13"},{"id":"595","name":"Edavaka","assemblyid":"123"},{"id":"94","name":"Edavanakkad","assemblyid":"67"},{"id":"633","name":"Edavanna","assemblyid":"93"},{"id":"1049","name":"Edavetty","assemblyid":"52"},{"id":"513","name":"Edavilangu","assemblyid":"72"},{"id":"301","name":"Edayoor","assemblyid":"95"},{"id":"737","name":"Elakamon","assemblyid":"13"},{"id":"748","name":"Elamad","assemblyid":"15"},{"id":"336","name":"Elamkulam","assemblyid":"100"},{"id":"95","name":"Elamkunnapuzha","assemblyid":"67"},{"id":"792","name":"Elampalloor","assemblyid":"22"},{"id":"82","name":"Elanji","assemblyid":"64"},{"id":"1082","name":"Elanthoor","assemblyid":"27"},{"id":"1072","name":"Elappara","assemblyid":"51"},{"id":"419","name":"Elappully","assemblyid":"84"},{"id":"540","name":"Elavally","assemblyid":"75"},{"id":"638","name":"Elavenchery","assemblyid":"86"},{"id":"961","name":"Elikkulam","assemblyid":"45"},{"id":"24","name":"Eloor","assemblyid":"57"},{"id":"936","name":"Enadinnangalam","assemblyid":"28"},{"id":"502","name":"Engandiyur","assemblyid":"70"},{"id":"183","name":"Enmakaje","assemblyid":"138"},{"id":"292","name":"Eramala","assemblyid":"121"},{"id":"626","name":"Eramamkuttoor","assemblyid":"132"},{"id":"163","name":"Eranholi","assemblyid":"135"},{"id":"946","name":"Erathu","assemblyid":"26"},{"id":"1037","name":"Erattayar","assemblyid":"53"},{"id":"1021","name":"Erattupetta","assemblyid":"46"},{"id":"1089","name":"Eraviperoor","assemblyid":"27"},{"id":"945","name":"Erhamkulam","assemblyid":"26"},{"id":"394","name":"Erimayur","assemblyid":"81"},{"id":"515","name":"Eriyad","assemblyid":"72"},{"id":"821","name":"Eroor","assemblyid":"25"},{"id":"530","name":"Erumapetty","assemblyid":"74"},{"id":"1016","name":"Erumely","assemblyid":"46"},{"id":"401","name":"Eruthempathy","assemblyid":"82"},{"id":"122","name":"Eruvassy","assemblyid":"127"},'
    //     '{"id":"986","name":"Ettumanoor","assemblyid":"41"},{"id":"64","name":"Ezhikkara","assemblyid":"62"},{"id":"126","name":"Ezhome","assemblyid":"128"},{"id":"784","name":"Ezhukone","assemblyid":"21"},{"id":"918","name":"Ezhumattoor","assemblyid":"29"},{"id":"828","name":"Ezhupunna","assemblyid":"33"},{"id":"217","name":"Feroke","assemblyid":"110"},{"id":"496","name":"Guruvayoor","assemblyid":"70"},{"id":"872","name":"Haripad","assemblyid":"36"},{"id":"1061","name":"Idukki-Kanjikuzhi","assemblyid":"50"},{"id":"123","name":"Irikkur","assemblyid":"127"},{"id":"302","name":"Irimbiliyam","assemblyid":"95"},{"id":"504","name":"Irinjalakuda","assemblyid":"71"},{"id":"1092","name":"Iritty","assemblyid":"133"},{"id":"749","name":"Ittiva","assemblyid":"15"},{"id":"750","name":"Kadakkal","assemblyid":"15"},{"id":"837","name":"Kadakkarappally","assemblyid":"35"},{"id":"669","name":"Kadakkavoor","assemblyid":"3"},{"id":"218","name":"Kadalundi","assemblyid":"110"},{"id":"92","name":"Kadamakudy","assemblyid":"67"},{"id":"109","name":"Kadambur","assemblyid":"126"},{"id":"948","name":"Kadampanadu","assemblyid":"26"},{"id":"436","name":"Kadampazhipuram","assemblyid":"87"},{"id":"951","name":"Kadanad","assemblyid":"45"},{"id":"531","name":"Kadangode","assemblyid":"74"},{"id":"127","name":"Kadannappalli-Panapuzha","assemblyid":"128"},{"id":"962","name":"Kadaplamattom","assemblyid":"42"},{"id":"497","name":"Kadappuram","assemblyid":"70"},{"id":"906","name":"Kadapra","assemblyid":"30"},{"id":"532","name":"Kadavallur","assemblyid":"74"},{"id":"672","name":"Kadinamkulam","assemblyid":"3"},{"id":"164","name":"Kadirur","assemblyid":"135"},{"id":"480","name":"Kadukutty","assemblyid":"68"},{"id":"25","name":"Kadungalloor","assemblyid":"57"},{"id":"969","name":"Kaduthuruthy","assemblyid":"42"},{"id":"857","name":"Kainakary","assemblyid":"38"},{"id":"516","name":"Kaipamangalam","assemblyid":"72"},{"id":"578","name":"Kaiparamba","assemblyid":"80"},{"id":"222","name":"Kakkodi","assemblyid":"111"},{"id":"223","name":"Kakkur","assemblyid":"111"},{"id":"11","name":"Kalady","assemblyid":"55"},{"id":"355","name":"Kalady","assemblyid":"103"},{"id":"22","name":"Kalamassery","assemblyid":"57"},{"id":"937","name":"Kalanjoor","assemblyid":"28"},{"id":"386","name":"Kalikavu","assemblyid":"108"},{"id":"170","name":"Kallar","assemblyid":"136"},{"id":"729","name":"Kallara","assemblyid":"12"},{"id":"975","name":"Kallara","assemblyid":"48"},{"id":"1093","name":"Kallara Vaikom ","assemblyid":"48"},{"id":"128","name":"Kalliasseri","assemblyid":"128"},{"id":"712","name":"Kallikkad","assemblyid":"10"},{"id":"688","name":"Kalliyoor","assemblyid":"6"},{"id":"913","name":"Kallooppara","assemblyid":"30"},{"id":"53","name":"Kalloorkad","assemblyid":"61"},{"id":"757","name":"Kalluvathukkal","assemblyid":"16"},{"id":"362","name":"Kalpakancheri","assemblyid":"104"},{"id":"584","name":"Kalpetta","assemblyid":"122"},{"id":"1064","name":"Kamakshy","assemblyid":"50"},{"id":"963","name":"Kanakkari","assemblyid":"42"},{"id":"1065","name":"Kanchiyar","assemblyid":"50"},{"id":"881","name":"Kandalloor","assemblyid":"37"},{"id":"539","name":"Kandanassery","assemblyid":"75"},{"id":"1010","name":"Kangazha","assemblyid":"43"},{"id":"167","name":"Kanhangad","assemblyid":"136"},{"id":"409","name":"Kanhirapuzha","assemblyid":"83"},{"id":"585","name":"Kaniambetta","assemblyid":"122"},{"id":"145","name":"Kanichar","assemblyid":"133"},{"id":"838","name":"Kanjikkuzhi","assemblyid":"35"},{"id":"690","name":"Kanjiramkulam","assemblyid":"6"},{"id":"1008","name":"Kanjirappally","assemblyid":"43"},{"id":"5","name":"Kanjoor","assemblyid":"54"},{"id":"627","name":"Kankole-Alapadamba","assemblyid":"132"},{"id":"443","name":"Kannadi","assemblyid":"88"},{"id":"380","name":"Kannamangalam","assemblyid":"107"},{"id":"462","name":"Kannambra","assemblyid":"91"},{"id":"129","name":"Kannapuram","assemblyid":"128"},{"id":"100","name":"Kannur Corporation","assemblyid":"125"},{"id":"1028","name":"Kanthalloor","assemblyid":"49"},{"id":"472","name":"Kappur","assemblyid":"92"},{"id":"179","name":"Karadka","assemblyid":"137"},{"id":"697","name":"Karakulam","assemblyid":"7"},{"id":"410","name":"Karakurissi","assemblyid":"83"},{"id":"506","name":"Karalam","assemblyid":"71"},{"id":"282","name":"Karassery","assemblyid":"120"},{"id":"822","name":"Karavaloor","assemblyid":"25"},{"id":"657","name":"Karavaram","assemblyid":"2"},{"id":"785","name":"Kareepra","assemblyid":"21"},{"id":"1050","name":"Karimannoor","assemblyid":"52"},{"id":"412","name":"Karimba","assemblyid":"83"},{"id":"1051","name":"Karimkunnam","assemblyid":"52"},{"id":"437","name":"Karimpuzha","assemblyid":"87"},{"id":"628","name":"Karivellur Peralam","assemblyid":"132"},{"id":"707","name":"Karode","assemblyid":"9"},{"id":"952","name":"Karoor","assemblyid":"45"},{"id":"873","name":"Karthikappally","assemblyid":"36"},{"id":"1011","name":"Karukachal","assemblyid":"43"},{"id":"12","name":"Karukutty","assemblyid":"55"},{"id":"329","name":"Karulai","assemblyid":"99"},{"id":"27","name":"Karumalloor","assemblyid":"57"},{"id":"691","name":"Karumkulam","assemblyid":"6"},{"id":"778","name":"Karunagappally","assemblyid":"19"},{"id":"1038","name":"Karunapuram","assemblyid":"53"},{"id":"387","name":"Karuvarakundu","assemblyid":"108"},{"id":"874","name":"Karuvatta","assemblyid":"36"},{"id":"175","name":"Kasaragod","assemblyid":"137"},{"id":"674","name":"Kattakada","assemblyid":"4"},{"id":"533","name":"Kattakampal","assemblyid":"74"},{"id":"1066","name":"Kattappana","assemblyid":"50"},{"id":"231","name":"Kattippara","assemblyid":"112"},{"id":"507","name":"Kattur","assemblyid":"71"},{"id":"858","name":"Kavalam","assemblyid":"38"},{"id":"33","name":"Kavalangad","assemblyid":"59"},{"id":"634","name":"Kavannoor","assemblyid":"93"},{"id":"463","name":"Kavasseri","assemblyid":"91"},{"id":"264","name":"Kavilumpara","assemblyid":"118"},{"id":"907","name":"Kaviyoor","assemblyid":"30"},{"id":"265","name":"Kayakkodi","assemblyid":"118"},{"id":"879","name":"Kayamkulam","assemblyid":"37"},{"id":"210","name":"Kayanna","assemblyid":"109"},{"id":"193","name":"Kayyur-Cheemeni","assemblyid":"139"},{"id":"680","name":"Kazhakoottam","assemblyid":"5"},{"id":"34","name":"Keerampara","assemblyid":"59"},{"id":"617","name":"Keezhallur","assemblyid":"131"},{"id":"276","name":"Keezhariyur","assemblyid":"119"},{"id":"318","name":"Keezhattur","assemblyid":"97"},{"id":"6","name":"Keezhmad","assemblyid":"54"},{"id":"146","name":"Keezhur-Chavassery","assemblyid":"133"},{"id":"147","name":"Kelakam","assemblyid":"133"},{"id":"413","name":"Keralassery","assemblyid":"83"},{"id":"964","name":"Kidangoor","assemblyid":"42"},{"id":"658","name":"Kilimanoor","assemblyid":"2"},{"id":"171","name":"Kinanoor-Karindalam","assemblyid":"136"},{"id":"42","name":"Kizhakkambalam","assemblyid":"60"},{"id":"395","name":"Kizhakkencheri","assemblyid":"81"},{"id":"229","name":"Kizhakkoth","assemblyid":"112"},{"id":"635","name":"Kizhuparamba","assemblyid":"93"},{"id":"670","name":"Kizhuvilam","assemblyid":"3"},{"id":"481","name":"Kodakara","assemblyid":"68"},{"id":"829","name":"Kodamthuruth","assemblyid":"33"},{"id":"482","name":"Kodassery","assemblyid":"68"},{"id":"283","name":"Kodencheri","assemblyid":"120"},{"id":"1052","name":"Kodikulam","assemblyid":"52"},{"id":"284","name":"Kodiyathur","assemblyid":"120"},{"id":"172","name":"Kodom-Belur","assemblyid":"136"},{"id":"420","name":"Kodumba","assemblyid":"84"},{"id":"944","name":"Kodumon","assemblyid":"26"},{"id":"520","name":"Kodungallur","assemblyid":"73"},{"id":"313","name":"Kodur","assemblyid":"96"},{"id":"230","name":"Koduvally","assemblyid":"112"},{"id":"639","name":"Koduvayur","assemblyid":"86"},{"id":"1090","name":"Koipram","assemblyid":"27"},{"id":"1073","name":"Kokkayar","assemblyid":"51"},{"id":"156","name":"Kolacherry","assemblyid":"134"},{"id":"621","name":"Kolayad","assemblyid":"131"},{"id":"579","name":"Kolazhy","assemblyid":"80"},{"id":"760","name":"Kollam Corporation","assemblyid":"17"},{"id":"713","name":"Kollayil","assemblyid":"10"},{"id":"640","name":"Kollengode","assemblyid":"86"},{"id":"488","name":"Kondazhy","assemblyid":"69"},{"id":"296","name":"Kondotty","assemblyid":"94"},{"id":"414","name":"Kongad","assemblyid":"83"},{"id":"1067","name":"Konnathady","assemblyid":"50"},{"id":"930","name":"Konni","assemblyid":"28"},{"id":"618","name":"Koodali","assemblyid":"131"},{"id":"285","name":"Koodaranji","assemblyid":"120"},{"id":"211","name":"Koorachundu","assemblyid":"109"},{"id":"995","name":"Kooroppada","assemblyid":"47"},{"id":"277","name":"Koothali","assemblyid":"119"},{"id":"83","name":"Koothattukulam","assemblyid":"64"},{"id":"1017","name":"Koottickal","assemblyid":"46"},{"id":"320","name":"Koottilangadi","assemblyid":"98"},{"id":"71","name":"Koovappady","assemblyid":"63"},{"id":"446","name":"Koppam","assemblyid":"89"},{"id":"483","name":"Koratty","assemblyid":"68"},{"id":"1018","name":"Koruthodu","assemblyid":"46"},{"id":"32","name":"Kothamangalam","assemblyid":"59"},{"id":"303","name":"Kottakkal","assemblyid":"95"},{"id":"793","name":"Kottamkara","assemblyid":"22"},{"id":"919","name":"Kottanad","assemblyid":"29"},{"id":"920","name":"Kottangal","assemblyid":"29"},{"id":"35","name":"Kottappady","assemblyid":"59"},{"id":"786","name":"Kottarakkara","assemblyid":"21"},{"id":"586","name":"Kottathara","assemblyid":"122"},{"id":"990","name":"Kottayam","assemblyid":"44"},{"id":"137","name":"Kottayam-Malabar","assemblyid":"130"},{"id":"464","name":"Kottayi","assemblyid":"91"},{"id":"148","name":"Kottiyoor","assemblyid":"133"},{"id":"428","name":"Kottoppadam","assemblyid":"85"},{"id":"692","name":"Kottukal","assemblyid":"6"},{"id":"212","name":"Kottur","assemblyid":"109"},{"id":"65","name":"Kottuvally","assemblyid":"62"},{"id":"236","name":"Koyilandy","assemblyid":"113"},{"id":"1083","name":"Kozhenchery","assemblyid":"27"},{"id":"220","name":"Kozhikode Corporation","assemblyid":"110"},{"id":"402","name":"Kozhinjampara","assemblyid":"82"},{"id":"953","name":"Kozhuvanal","assemblyid":"45"},{"id":"882","name":"Krishnapuram","assemblyid":"37"},{"id":"743","name":"Kudappanakunnu","assemblyid":"14"},{"id":"1062","name":"Kudayathoor","assemblyid":"50"},{"id":"787","name":"Kulakkada","assemblyid":"21"},{"id":"1084","name":"Kulanada","assemblyid":"27"},{"id":"774","name":"Kulasekharapuram","assemblyid":"19"},{"id":"708","name":"Kulathoor","assemblyid":"9"},{"id":"823","name":"Kulathupuzha","assemblyid":"25"},{"id":"447","name":"Kulukkallur","assemblyid":"89"},{"id":"987","name":"Kumarakom","assemblyid":"41"},{"id":"1053","name":"Kumaramangalam","assemblyid":"52"},{"id":"429","name":"Kumaramputhur","assemblyid":"85"},{"id":"875","name":"Kumarapuram","assemblyid":"36"},{"id":"612","name":"Kumbalam","assemblyid":"66"},{"id":"30","name":"Kumbalangi","assemblyid":"58"},{"id":"180","name":"Kumbdaje","assemblyid":"137"},{"id":"184","name":"Kumbla","assemblyid":"138"},{"id":"1074","name":"Kumily","assemblyid":"51"},{"id":"794","name":"Kundara","assemblyid":"22"},{"id":"130","name":"Kunhimangalam","assemblyid":"128"},{"id":"249","name":"Kunnamangalam","assemblyid":"116"},{"id":"528","name":"Kunnamkulam","assemblyid":"74"},{"id":"916","name":"Kunnamthanam","assemblyid":"30"},{"id":"714","name":"Kunnathukal","assemblyid":"10"},{"id":"43","name":"Kunnathunad","assemblyid":"60"},'
    //     '{"id":"801","name":"Kunnathur","assemblyid":"23"},{"id":"138","name":"Kunnothuparambu","assemblyid":"130"},{"id":"26","name":"Kunnukara","assemblyid":"57"},{"id":"255","name":"Kunnummal","assemblyid":"117"},{"id":"965","name":"Kuravilangad","assemblyid":"42"},{"id":"1002","name":"Kurichy","assemblyid":"40"},{"id":"155","name":"Kurumathur","assemblyid":"134"},{"id":"321","name":"Kuruva","assemblyid":"98"},{"id":"224","name":"Kuruvattur","assemblyid":"111"},{"id":"465","name":"Kuthanur","assemblyid":"91"},{"id":"830","name":"Kuthiathode","assemblyid":"33"},{"id":"136","name":"Kuthuparamba","assemblyid":"130"},{"id":"36","name":"Kuttampuzha","assemblyid":"59"},{"id":"256","name":"Kuttiadi","assemblyid":"117"},{"id":"157","name":"Kuttiattoor","assemblyid":"134"},{"id":"654","name":"Kuttichal","assemblyid":"1"},{"id":"203","name":"Kuttikole","assemblyid":"140"},{"id":"304","name":"Kuttippuram","assemblyid":"95"},{"id":"908","name":"Kuttoor","assemblyid":"30"},{"id":"396","name":"Kuzhalmannam","assemblyid":"81"},{"id":"637","name":"Kuzhimanna","assemblyid":"93"},'
    //     '{"id":"96","name":"Kuzhuppilly","assemblyid":"67"},{"id":"524","name":"Kuzhur","assemblyid":"73"},{"id":"438","name":"Lakkidi-Perur","assemblyid":"87"},{"id":"555","name":"Madakkathara","assemblyid":"77"},{"id":"1003","name":"Madappally","assemblyid":"40"},{"id":"738","name":"Madavoor","assemblyid":"13"},{"id":"232","name":"Madavoor","assemblyid":"112"},{"id":"131","name":"Madayi","assemblyid":"128"},{"id":"181","name":"Madhur","assemblyid":"137"},{"id":"173","name":"Madikai","assemblyid":"136"},{"id":"322","name":"Makkaraparamba","assemblyid":"98"},{"id":"525","name":"Mala","assemblyid":"73"},{"id":"421","name":"Malampuzha","assemblyid":"84"},{"id":"158","name":"Malapattam","assemblyid":"134"},{"id":"308","name":"Malappuram","assemblyid":"96"},{"id":"931","name":"Malayalapuzha","assemblyid":"28"},{"id":"13","name":"Malayattoor-Neeleswaram","assemblyid":"55"},{"id":"675","name":"Malayinkeezhu","assemblyid":"4"},{"id":"914","name":"Mallappally","assemblyid":"30"},{"id":"1085","name":"Mallapuzhassery","assemblyid":"27"},{"id":"619","name":"Malur","assemblyid":"131"},{"id":"388","name":"Mampad","assemblyid":"108"},{"id":"1054","name":"Manakkad","assemblyid":"52"},{"id":"537","name":"Manalur","assemblyid":"75"},{"id":"664","name":"Manamboor","assemblyid":"2"},{"id":"596","name":"Mananthavady","assemblyid":"123"},{"id":"996","name":"Manarcad","assemblyid":"47"},{"id":"84","name":"Maneed","assemblyid":"64"},{"id":"358","name":"Mangalam","assemblyid":"103"},{"id":"673","name":"Mangalapuram","assemblyid":"3"},{"id":"185","name":"Mangalpady","assemblyid":"138"},{"id":"620","name":"Mangattidam","assemblyid":"131"},{"id":"696","name":"Manikkal","assemblyid":"7"},{"id":"1009","name":"Manimala","assemblyid":"43"},{"id":"260","name":"Maniyur","assemblyid":"117"},{"id":"54","name":"Manjalloor","assemblyid":"61"},{"id":"14","name":"Manjapra","assemblyid":"55"},{"id":"314","name":"Manjeri","assemblyid":"97"},{"id":"186","name":"Manjeshwaram","assemblyid":"138"},{"id":"970","name":"Manjoor","assemblyid":"42"},{"id":"323","name":"Mankada","assemblyid":"98"},{"id":"415","name":"Mankara","assemblyid":"83"},{"id":"1029","name":"Mankulam","assemblyid":"49"},{"id":"846","name":"Mannanchery","assemblyid":"31"},{"id":"898","name":"Mannar","assemblyid":"34"},{"id":"431","name":"Mannarkkad","assemblyid":"85"},{"id":"416","name":"Mannur","assemblyid":"83"},{"id":"613","name":"Maradu","assemblyid":"66"},{"id":"55","name":"Marady","assemblyid":"61"},{"id":"305","name":"Marakkara","assemblyid":"95"},{"id":"676","name":"Maranalloor","assemblyid":"4"},{"id":"343","name":"Maranchery","assemblyid":"101"},{"id":"966","name":"Marangattupilly","assemblyid":"42"},{"id":"848","name":"Mararikkulam North","assemblyid":"31"},{"id":"847","name":"Mararikkulam South","assemblyid":"31"},{"id":"976","name":"Maravanthuruthu","assemblyid":"48"},{"id":"1030","name":"Marayoor","assemblyid":"49"},{"id":"1068","name":"Mariapuram","assemblyid":"50"},{"id":"422","name":"Marutharoad","assemblyid":"84"},{"id":"266","name":"Maruthonkara","assemblyid":"118"},{"id":"517","name":"Mathilakam","assemblyid":"72"},{"id":"445","name":"Mathur","assemblyid":"88"},{"id":"615","name":"Mattannur","assemblyid":"131"},{"id":"564","name":"Mattathur","assemblyid":"78"},{"id":"132","name":"Mattool","assemblyid":"128"},{"id":"886","name":"Mavelikkara","assemblyid":"39"},{"id":"889","name":"Mavelikkara-Thamarakkulam","assemblyid":"39"},{"id":"888","name":"Mavelikkara-Thekkekara","assemblyid":"39"},{"id":"250","name":"Mavoor","assemblyid":"116"},{"id":"771","name":"Mayyanad","assemblyid":"18"},{"id":"159","name":"Mayyil","assemblyid":"134"},{"id":"44","name":"Mazhuvannoor","assemblyid":"60"},{"id":"954","name":"Meenachil","assemblyid":"45"},{"id":"997","name":"Meenadom","assemblyid":"47"},{"id":"603","name":"Meenangadi","assemblyid":"124"},{"id":"187","name":"Meenja","assemblyid":"138"},{"id":"397","name":"Melarcode","assemblyid":"81"},{"id":"340","name":"Melattur","assemblyid":"100"},{"id":"809","name":"Melila","assemblyid":"24"},{"id":"955","name":"Melukavu","assemblyid":"45"},{"id":"484","name":"Melur","assemblyid":"68"},{"id":"587","name":"Meppadi","assemblyid":"122"},{"id":"278","name":"Meppayyur","assemblyid":"119"},{"id":"521","name":"Methala","assemblyid":"73"},{"id":"1086","name":"Mezhuveli","assemblyid":"27"},{"id":"182","name":"Mogral Puthur","assemblyid":"137"},{"id":"139","name":"Mokeri","assemblyid":"130"},{"id":"239","name":"Moodadi","assemblyid":"113"},{"id":"15","name":"Mookkannoor","assemblyid":"55"},{"id":"956","name":"Moonnilavu","assemblyid":"45"},{"id":"374","name":"Moonniyur","assemblyid":"106"},{"id":"324","name":"Moorkkanad","assemblyid":"98"},{"id":"330","name":"Moothedam","assemblyid":"99"},{"id":"309","name":"Morayur","assemblyid":"96"},{"id":"671","name":"Mudakkal","assemblyid":"3"},{"id":"72","name":"Mudakkuzha","assemblyid":"63"},{"id":"839","name":"Muhamma","assemblyid":"35"},{"id":"286","name":"Mukkom","assemblyid":"120"},{"id":"971","name":"Mulakulam","assemblyid":"42"},{"id":"899","name":"Mulakuzha","assemblyid":"34"},{"id":"580","name":"Mulamkunnathukavu","assemblyid":"80"},{"id":"80","name":"Mulanthuruthy","assemblyid":"64"},{"id":"93","name":"Mulavukad","assemblyid":"67"},{"id":"204","name":"Muliyar","assemblyid":"140"},{"id":"541","name":"Mullasseyy","assemblyid":"75"},{"id":"604","name":"Mullenkolly","assemblyid":"124"},{"id":"489","name":"Mullurkara","assemblyid":"69"},{"id":"1019","name":"Mundakayam","assemblyid":"46"},{"id":"135","name":"Munderi","assemblyid":"129"},{"id":"800","name":"Mundrothuruth","assemblyid":"23"},{"id":"423","name":"Mundur","assemblyid":"84"},{"id":"1031","name":"Munnar","assemblyid":"49"},{"id":"588","name":"Muppanad","assemblyid":"122"},{"id":"508","name":"Muriyad","assemblyid":"71"},{"id":"641","name":"Muthalamada","assemblyid":"86"},{"id":"957","name":"Mutholy","assemblyid":"45"},{"id":"876","name":"Muthukulam","assemblyid":"36"},{"id":"448","name":"Muthuthala","assemblyid":"89"},{"id":"299","name":"Muthuvallur","assemblyid":"94"},{"id":"859","name":"Muttar","assemblyid":"38"},{"id":"589","name":"Muttil","assemblyid":"122"},{"id":"1055","name":"Muttom","assemblyid":"52"},{"id":"49","name":"Muvattupuzha","assemblyid":"61"},{"id":"149","name":"Muzhakkunnu","assemblyid":"133"},{"id":"110","name":"Muzhappilangad","assemblyid":"126"},{"id":"933","name":"Mylapra","assemblyid":"28"},{"id":"788","name":"Mylom","assemblyid":"21"},{"id":"802","name":"Mynagappally","assemblyid":"23"},{"id":"267","name":"Nadapuram","assemblyid":"118"},{"id":"556","name":"Nadathara","assemblyid":"77"},{"id":"213","name":"Naduvannur","assemblyid":"109"},{"id":"119","name":"Naduvil","assemblyid":"127"},{"id":"473","name":"Nagalassery","assemblyid":"92"},{"id":"659","name":"Nagaroor","assemblyid":"2"},{"id":"403","name":"Nalleppilly","assemblyid":"82"},{"id":"225","name":"Nanmanda","assemblyid":"111"},{"id":"368","name":"Nannambra","assemblyid":"105"},{"id":"344","name":"Nannamukku","assemblyid":"101"},{"id":"730","name":"Nanniyode","assemblyid":"12"},{"id":"922","name":"Naranammoozhi","assemblyid":"29"},{"id":"1087","name":"Naranganam","assemblyid":"27"},{"id":"103","name":"Narath","assemblyid":"125"},{"id":"233","name":"Narikkuni","assemblyid":"112"},{"id":"268","name":"Narippatta","assemblyid":"118"},{"id":"552","name":"Nattika","assemblyid":"76"},{"id":"739","name":"Navaikulam","assemblyid":"13"},{"id":"97","name":"Nayarambalam","assemblyid":"67"},{"id":"695","name":"Nedumangad","assemblyid":"7"},{"id":"7","name":"Nedumbassery","assemblyid":"54"},{"id":"1039","name":"Nedumkandam","assemblyid":"53"},{"id":"1012","name":"Nedumkunnam","assemblyid":"43"},{"id":"795","name":"Nedumpana","assemblyid":"22"},{"id":"909","name":"Nedumpram","assemblyid":"30"},{"id":"860","name":"Nedumudi","assemblyid":"38"},{"id":"789","name":"Neduvathur","assemblyid":"21"},{"id":"861","name":"Neelamperoor","assemblyid":"38"},{"id":"764","name":"Neendakara","assemblyid":"17"},{"id":"988","name":"Neendoor","assemblyid":"41"},{"id":"972","name":"Neezhoor","assemblyid":"42"},{"id":"725","name":"Nellanad","assemblyid":"12"},{"id":"458","name":"Nellaya","assemblyid":"90"},{"id":"37","name":"Nellikkuzhi","assemblyid":"59"},{"id":"642","name":"Nelliyampathy","assemblyid":"86"},{"id":"643","name":"Nemmara","assemblyid":"86"},{"id":"565","name":"Nemranikkara","assemblyid":"78"},{"id":"605","name":"Nenmeni","assemblyid":"124"},{"id":"165","name":"New-Mahe","assemblyid":"135"},{"id":"704","name":"Neyyattinkara","assemblyid":"9"},{"id":"331","name":"Nilambur","assemblyid":"99"},{"id":"751","name":"Nilamel","assemblyid":"15"},{"id":"194","name":"Nileshwar","assemblyid":"139"},{"id":"348","name":"Niramaruthur","assemblyid":"102"},{"id":"910","name":"Niranam","assemblyid":"30"},{"id":"98","name":"Njarakkal","assemblyid":"67"},{"id":"279","name":"Nochad","assemblyid":"119"},{"id":"606","name":"Noolpuzha","assemblyid":"124"},{"id":"890","name":"Nooranad","assemblyid":"39"},{"id":"61","name":"North Paravur","assemblyid":"62"},{"id":"775","name":"Oachira","assemblyid":"19"},{"id":"73","name":"Okkal","assemblyid":"63"},{"id":"251","name":"Olavanna","assemblyid":"116"},{"id":"1088","name":"Omalloor","assemblyid":"27"},{"id":"234","name":"Omassery","assemblyid":"112"},{"id":"293","name":"Onchiam","assemblyid":"121"},{"id":"449","name":"Ongallur","assemblyid":"89"},{"id":"498","name":"Orumanayur","assemblyid":"70"},{"id":"381","name":"Othukkungal","assemblyid":"107"},{"id":"434","name":"Ottapalam","assemblyid":"87"},{"id":"715","name":"Ottasekharamangalam","assemblyid":"10"},{"id":"665","name":"Ottoor","assemblyid":"2"},{"id":"349","name":"Ozhur","assemblyid":"102"},{"id":"590","name":"Padinharethara","assemblyid":"122"},{"id":"509","name":"Padiyur","assemblyid":"71"},{"id":"623","name":"Padiyur-Kalliad","assemblyid":"131"},{"id":"195","name":"Padne","assemblyid":"139"},{"id":"59","name":"Paingottoor","assemblyid":"61"},{"id":"1004","name":"Paippad","assemblyid":"40"},{"id":"56","name":"Paipra","assemblyid":"61"},{"id":"188","name":"Paivalike","assemblyid":"138"},{"id":"949","name":"Pala","assemblyid":"45"},{"id":"442","name":"Palakkad","assemblyid":"88"},{"id":"57","name":"Palakkuzha","assemblyid":"61"},{"id":"891","name":"Palamel","assemblyid":"39"},{"id":"38","name":"Pallarimangalam","assemblyid":"59"},{"id":"644","name":"Pallassana","assemblyid":"86"},{"id":"679","name":"Pallichal","assemblyid":"4"},{"id":"740","name":"Pallickal","assemblyid":"13"},{"id":"947","name":"Pallickal","assemblyid":"26"},{"id":"205","name":"Pallikere","assemblyid":"140"},{"id":"375","name":"Pallikkal","assemblyid":"106"},{"id":"1015","name":"Pallikkathode","assemblyid":"43"},{"id":"877","name":"Pallippad","assemblyid":"36"},{"id":"99","name":"Pallippuram","assemblyid":"67"},{"id":"1032","name":"Pallivasal","assemblyid":"49"},{"id":"1040","name":"Pampadumpara","assemblyid":"53"},{"id":"998","name":"Pampady","assemblyid":"47"},{"id":"85","name":"Pampakuda","assemblyid":"64"},{"id":"991","name":"Panachikkad","assemblyid":"44"},{"id":"597","name":"Panamaram","assemblyid":"123"},{"id":"557","name":"Pananchery","assemblyid":"77"},{"id":"214","name":"Panangad","assemblyid":"109"},{"id":"174","name":"Panathady","assemblyid":"136"},{"id":"831","name":"Panavally","assemblyid":"33"},{"id":"731","name":"Panavoor","assemblyid":"12"},{"id":"779","name":"Panayam","assemblyid":"20"},{"id":"941","name":"Pandalam","assemblyid":"26"},{"id":"943","name":"Pandalam Thekkekara","assemblyid":"26"},{"id":"900","name":"Pandanad","assemblyid":"34"},{"id":"315","name":"Pandikkad","assemblyid":"97"},{"id":"732","name":"Pangode","assemblyid":"12"},{"id":"490","name":"Panjal","assemblyid":"69"},{"id":"765","name":"Panmana","assemblyid":"17"},{"id":"166","name":"Panniyannur","assemblyid":"135"},{"id":"140","name":"Panoor","assemblyid":"130"},{"id":"104","name":"Pappinisseri","assemblyid":"125"},{"id":"16","name":"Parakkadavu","assemblyid":"55"},{"id":"550","name":"Paralam","assemblyid":"76"},{"id":"417","name":"Parali","assemblyid":"83"},{"id":"369","name":"Parappanangadi","assemblyid":"105"},{"id":"566","name":"Parappukkara","assemblyid":"78"},{"id":"382","name":"Parappur","assemblyid":"107"},{"id":"716","name":"Parassala","assemblyid":"10"},{"id":"1020","name":"Parathode","assemblyid":"46"},{"id":"753","name":"Paravur","assemblyid":"16"},{"id":"485","name":"Pariyaram","assemblyid":"68"},'
    //     '{"id":"160","name":"Pariyaram","assemblyid":"134"},{"id":"474","name":"Parudur","assemblyid":"92"},{"id":"1079","name":"Pathanamthitta","assemblyid":"27"},{"id":"811","name":"Pathanapuram","assemblyid":"24"},{"id":"883","name":"Pathiyoor","assemblyid":"37"},{"id":"450","name":"Pattambi","assemblyid":"89"},{"id":"840","name":"Pattanakkad","assemblyid":"35"},{"id":"404","name":"Pattanchery","assemblyid":"82"},{"id":"812","name":"Pattazhy","assemblyid":"24"},{"id":"813","name":"Pattazhy Vadakkekara","assemblyid":"24"},{"id":"141","name":"Pattiom","assemblyid":"130"},{"id":"475","name":"Pattithara","assemblyid":"92"},{"id":"133","name":"Pattuvam","assemblyid":"128"},{"id":"543","name":"Pavaratty","assemblyid":"75"},{"id":"808","name":"Pavithreswaram","assemblyid":"23"},{"id":"150","name":"Payam","assemblyid":"133"},{"id":"624","name":"Payyannur","assemblyid":"132"},{"id":"116","name":"Payyavoor","assemblyid":"127"},{"id":"240","name":"Payyoli","assemblyid":"113"},{"id":"660","name":"Pazhayakunnummel","assemblyid":"2"},{"id":"491","name":"Pazhayannur","assemblyid":"69"},{"id":"1075","name":"Peerumade","assemblyid":"51"},{"id":"111","name":"Peralasseri","assemblyid":"126"},{"id":"280","name":"Perambra","assemblyid":"119"},{"id":"151","name":"Peravoor","assemblyid":"133"},{"id":"796","name":"Perayam","assemblyid":"22"},{"id":"797","name":"Perinad","assemblyid":"22"},{"id":"733","name":"Peringamala","assemblyid":"12"},{"id":"911","name":"Peringara","assemblyid":"30"},{"id":"629","name":"Peringome Vayakkara","assemblyid":"132"},{"id":"466","name":"Peringottukurissi","assemblyid":"91"},{"id":"518","name":"Perinjanam","assemblyid":"72"},{"id":"334","name":"Perinthalmanna","assemblyid":"100"},{"id":"252","name":"Perumanna","assemblyid":"116"},{"id":"372","name":"Perumanna-Klari","assemblyid":"105"},{"id":"405","name":"Perumatty","assemblyid":"82"},{"id":"832","name":"Perumbalam","assemblyid":"33"},{"id":"69","name":"Perumbavoor","assemblyid":"63"},{"id":"717","name":"Perumkadavila","assemblyid":"10"},{"id":"345","name":"Perumpadappu","assemblyid":"101"},{"id":"376","name":"Peruvallur","assemblyid":"106"},{"id":"1076","name":"Peruvanthanam","assemblyid":"51"},{"id":"253","name":"Peruvayal","assemblyid":"116"},{"id":"407","name":"Peruvemba","assemblyid":"82"},{"id":"196","name":"Pilicode","assemblyid":"139"},{"id":"113","name":"Pinarayi","assemblyid":"126"},{"id":"39","name":"Pindimana","assemblyid":"59"},{"id":"814","name":"Piravanthoor","assemblyid":"24"},{"id":"88","name":"Piravom","assemblyid":"64"},{"id":"444","name":"Pirayiri","assemblyid":"88"},{"id":"408","name":"Polpully","assemblyid":"82"},{"id":"306","name":"Ponmala","assemblyid":"95"},{"id":"350","name":"Ponmundam","assemblyid":"102"},{"id":"341","name":"Ponnani","assemblyid":"101"},{"id":"439","name":"Pookkottukavu","assemblyid":"87"},{"id":"310","name":"Pookkottur","assemblyid":"96"},{"id":"499","name":"Pookode","assemblyid":"70"},{"id":"510","name":"Poomangalam","assemblyid":"71"},{"id":"1022","name":"Poonjar","assemblyid":"46"},{"id":"1023","name":"Poonjar Thekkekara","assemblyid":"46"},{"id":"607","name":"Poothadi","assemblyid":"124"},{"id":"758","name":"Poothakkulam","assemblyid":"16"},{"id":"45","name":"Poothrikka","assemblyid":"60"},{"id":"655","name":"Poovachal","assemblyid":"1"},{"id":"693","name":"Poovar","assemblyid":"6"},{"id":"759","name":"Pooyappally","assemblyid":"16"},{"id":"511","name":"Porathissery","assemblyid":"71"},{"id":"534","name":"Porkulam","assemblyid":"74"},{"id":"389","name":"Porur","assemblyid":"108"},{"id":"803","name":"Poruvazhy","assemblyid":"23"},{"id":"60","name":"Pothanicad","assemblyid":"61"},{"id":"699","name":"Pothencode","assemblyid":"7"},{"id":"332","name":"Pothukal","assemblyid":"99"},{"id":"522","name":"Poyya","assemblyid":"73"},{"id":"591","name":"Pozhuthana","assemblyid":"122"},{"id":"932","name":"Pramadom","assemblyid":"28"},{"id":"467","name":"Puducode","assemblyid":"91"},{"id":"425","name":"Puduppariyaram","assemblyid":"84"},{"id":"432","name":"Pudur","assemblyid":"85"},{"id":"424","name":"Pudussery","assemblyid":"84"},{"id":"337","name":"Pulamanthole","assemblyid":"100"},{"id":"297","name":"Pulikkal","assemblyid":"94"},{"id":"661","name":"Pulimath","assemblyid":"2"},{"id":"862","name":"Pulinkunnu","assemblyid":"38"},{"id":"901","name":"Puliyoor","assemblyid":"34"},{"id":"726","name":"Pullampara","assemblyid":"12"},{"id":"206","name":"Pullur-Periya","assemblyid":"140"},{"id":"608","name":"Pulpalli","assemblyid":"124"},{"id":"312","name":"Pulpatta","assemblyid":"96"},{"id":"817","name":"Punalur","assemblyid":"25"},{"id":"852","name":"Punnapra North","assemblyid":"32"},{"id":"853","name":"Punnapra South","assemblyid":"32"},{"id":"500","name":"Punnayur","assemblyid":"70"},{"id":"501","name":"Punnayurkulam","assemblyid":"70"},{"id":"854","name":"Purakkad","assemblyid":"32"},{"id":"915","name":"Puramattom","assemblyid":"30"},{"id":"257","name":"Purameri","assemblyid":"117"},{"id":"1056","name":"Purapuzha","assemblyid":"52"},{"id":"357","name":"Purathur","assemblyid":"103"},{"id":"526","name":"Puthenchira","assemblyid":"73"},{"id":"66","name":"Puthenvelikkara","assemblyid":"62"},{"id":"189","name":"Puthige","assemblyid":"138"},{"id":"567","name":"Puthukkad","assemblyid":"78"},{"id":"646","name":"Puthunagaram","assemblyid":"86"},{"id":"287","name":"Puthuppadi","assemblyid":"120"},{"id":"999","name":"Puthuppally","assemblyid":"47"},{"id":"558","name":"Puthur","assemblyid":"77"},{"id":"325","name":"Puzhakkattiri","assemblyid":"98"},{"id":"1041","name":"Rajakkad","assemblyid":"53"},{"id":"1042","name":"Rajakumari","assemblyid":"53"},{"id":"86","name":"Ramamangalam","assemblyid":"64"},{"id":"219","name":"Ramanattukara","assemblyid":"110"},{"id":"863","name":"Ramankary","assemblyid":"38"},{"id":"630","name":"Ramanthali","assemblyid":"132"},{"id":"958","name":"Ramapuram","assemblyid":"45"},{"id":"917","name":"Ranni","assemblyid":"29"},{"id":"923","name":"Ranni-Angadi","assemblyid":"29"},{"id":"924","name":"Ranni-Pazhavangadi","assemblyid":"29"},{"id":"925","name":"Ranni-Perunad","assemblyid":"29"},{"id":"74","name":"Rayamangalam","assemblyid":"63"},{"id":"1043","name":"Santhanpara","assemblyid":"53"},{"id":"804","name":"Sasthamcotta","assemblyid":"23"},{"id":"939","name":"Seethathodu","assemblyid":"28"},{"id":"1044","name":"Senapathy","assemblyid":"53"},{"id":"433","name":"Sholayur","assemblyid":"85"},{"id":"454","name":"Shornur","assemblyid":"90"},{"id":"805","name":"Sooranad North","assemblyid":"23"},{"id":"806","name":"Sooranad South","assemblyid":"23"},{"id":"117","name":"Sreekandapuram","assemblyid":"127"},{"id":"681","name":"Sreekaryam","assemblyid":"5"},{"id":"440","name":"Sreekrishnapuram","assemblyid":"87"},{"id":"8","name":"Sreemoolnagaram","assemblyid":"54"},{"id":"519","name":"Sreenarayanapuram","assemblyid":"72"},{"id":"609","name":"Sulthan Bathery","assemblyid":"124"},{"id":"554","name":"Talikkulam","assemblyid":"76"},{"id":"152","name":"Taliparamba","assemblyid":"134"},{"id":"352","name":"Tanur","assemblyid":"102"},{"id":"468","name":"Tarur","assemblyid":"91"},{"id":"1024","name":"Teekoy","assemblyid":"46"},{"id":"411","name":"Thachampara","assemblyid":"83"},{"id":"441","name":"Thachanattukara","assemblyid":"87"},{"id":"544","name":"Thaikkad","assemblyid":"75"},{"id":"864","name":"Thakazhy","assemblyid":"38"},{"id":"363","name":"Thalakkad","assemblyid":"104"},{"id":"226","name":"Thalakkulathur","assemblyid":"111"},{"id":"959","name":"Thalanad","assemblyid":"45"},'
    //     '{"id":"960","name":"Thalappalam","assemblyid":"45"},{"id":"161","name":"Thalassery","assemblyid":"135"},{"id":"865","name":"Thalavady","assemblyid":"38"},{"id":"815","name":"Thalavoor","assemblyid":"24"},{"id":"978","name":"Thalayazham","assemblyid":"48"},{"id":"979","name":"Thalayolaparambu","assemblyid":"48"},{"id":"235","name":"Thamarassery","assemblyid":"112"},{"id":"351","name":"Thanalur","assemblyid":"102"},{"id":"841","name":"Thanneermukkam","assemblyid":"35"},{"id":"935","name":"Thannithode","assemblyid":"28"},{"id":"551","name":"Thanniyam","assemblyid":"76"},{"id":"592","name":"Thariyode","assemblyid":"122"},{"id":"354","name":"Thavanur","assemblyid":"103"},{"id":"598","name":"Thavinhal","assemblyid":"123"},{"id":"892","name":"Thazhakara","assemblyid":"39"},{"id":"776","name":"Thazhava","assemblyid":"19"},{"id":"338","name":"Thazhekode","assemblyid":"100"},{"id":"766","name":"Thekkumbhagom","assemblyid":"17"},{"id":"583","name":"Thekkumkara","assemblyid":"80"},{"id":"377","name":"Thenhippalam","assemblyid":"106"},{"id":"430","name":"Thenkara","assemblyid":"85"},{"id":"398","name":"Thenkurissi","assemblyid":"81"},{"id":"824","name":"Thenmala","assemblyid":"25"},{"id":"370","name":"Thennala","assemblyid":"105"},{"id":"767","name":"Thevalakkara","assemblyid":"17"},{"id":"1025","name":"Thidanad","assemblyid":"46"},{"id":"241","name":"Thikkody","assemblyid":"113"},{"id":"622","name":"Thillenkeri","assemblyid":"131"},{"id":"87","name":"Thirumarady","assemblyid":"64"},{"id":"476","name":"Thirumittacode","assemblyid":"92"},{"id":"364","name":"Thirunavaya","assemblyid":"104"},{"id":"599","name":"Thirunelly","assemblyid":"123"},{"id":"709","name":"Thirupuram","assemblyid":"9"},{"id":"390","name":"Thiruvali","assemblyid":"108"},{"id":"905","name":"Thiruvalla","assemblyid":"30"},{"id":"258","name":"Thiruvallur","assemblyid":"117"},{"id":"288","name":"Thiruvambadi","assemblyid":"120"},{"id":"682","name":"Thiruvananthapuram Corporation","assemblyid":"5"},{"id":"46","name":"Thiruvaniyoor","assemblyid":"60"},{"id":"81","name":"Thiruvankulam","assemblyid":"64"},{"id":"902","name":"Thiruvanvandoor","assemblyid":"34"},{"id":"989","name":"Thiruvarppu","assemblyid":"41"},{"id":"451","name":"Thiruvegapura","assemblyid":"89"},{"id":"492","name":"Thiruvilwamala","assemblyid":"69"},{"id":"777","name":"Thodiyoor","assemblyid":"19"},{"id":"1047","name":"Thodupuzha","assemblyid":"52"},{"id":"650","name":"Tholicode","assemblyid":"1"},{"id":"581","name":"Tholur","assemblyid":"80"},{"id":"600","name":"Thondernad","assemblyid":"123"},{"id":"1091","name":"Thottapuzhassery","assemblyid":"27"},{"id":"459","name":"Thrikkadeeri","assemblyid":"90"},{"id":"91","name":"Thrikkakara","assemblyid":"65"},{"id":"780","name":"Thrikkaruva","assemblyid":"20"},{"id":"1005","name":"Thrikkodithanam","assemblyid":"40"},{"id":"798","name":"Thrikkovilvattom","assemblyid":"22"},{"id":"878","name":"Thrikkunnapuzha","assemblyid":"36"},{"id":"359","name":"Thriprangode","assemblyid":"103"},{"id":"142","name":"Thriprangottur","assemblyid":"130"},{"id":"611","name":"Thripunithura","assemblyid":"66"},{"id":"559","name":"Thrissur Corporation","assemblyid":"77"},{"id":"477","name":"Thrithala","assemblyid":"92"},{"id":"942","name":"Thumbamon","assemblyid":"26"},{"id":"269","name":"Thuneri","assemblyid":"118"},{"id":"17","name":"Thuravoor","assemblyid":"55"},{"id":"834","name":"Thuravoor","assemblyid":"33"},{"id":"281","name":"Thurayur","assemblyid":"119"},{"id":"391","name":"Thuvvur","assemblyid":"108"},{"id":"833","name":"Thycattussery","assemblyid":"33"},{"id":"360","name":"Tirur Municipality","assemblyid":"104"},{"id":"371","name":"Tirurangadi","assemblyid":"105"},{"id":"197","name":"Trikaripur","assemblyid":"139"},{"id":"316","name":"Trikkalangode","assemblyid":"97"},{"id":"569","name":"Trikkur","assemblyid":"78"},{"id":"977","name":"TV Puram","assemblyid":"48"},{"id":"120","name":"Udayagiri","assemblyid":"127"},{"id":"614","name":"Udayamperoor","assemblyid":"66"},{"id":"980","name":"Udayanapuram","assemblyid":"48"},{"id":"207","name":"Udma","assemblyid":"140"},{"id":"1045","name":"Udumbanchola","assemblyid":"53"},{"id":"1057","name":"Udumbannoor","assemblyid":"52"},{"id":"121","name":"Ulikkal","assemblyid":"127"},{"id":"215","name":"Ulliyeri","assemblyid":"109"},{"id":"790","name":"Ummannoor","assemblyid":"21"},{"id":"216","name":"Unnikulam","assemblyid":"109"},{"id":"1077","name":"Upputhara","assemblyid":"51"},{"id":"383","name":"Urakam","assemblyid":"107"},{"id":"636","name":"Urangattiri","assemblyid":"93"},{"id":"652","name":"Uzhamalackal","assemblyid":"1"},{"id":"967","name":"Uzhavoor","assemblyid":"42"},{"id":"289","name":"Vadakara","assemblyid":"121"},{"id":"406","name":"Vadakarapathy","assemblyid":"82"},{"id":"503","name":"Vadakkekad","assemblyid":"70"},{"id":"68","name":"Vadakkekara","assemblyid":"62"},{"id":"469","name":"Vadakkencheri","assemblyid":"91"},{"id":"927","name":"Vadasserikkara","assemblyid":"29"},{"id":"647","name":"Vadavannur","assemblyid":"86"},{"id":"47","name":"Vadavucode-Puthencruz","assemblyid":"60"},{"id":"973","name":"Vaikom","assemblyid":"48"},{"id":"1000","name":"Vakathanam","assemblyid":"47"},{"id":"662","name":"Vakkom","assemblyid":"2"},{"id":"58","name":"Valakom","assemblyid":"61"},{"id":"307","name":"Valanchery","assemblyid":"95"},{"id":"105","name":"Valapattanam","assemblyid":"125"},{"id":"553","name":"Valappad","assemblyid":"76"},{"id":"365","name":"Valavannur","assemblyid":"104"},{"id":"270","name":"Valayam","assemblyid":"118"},{"id":"198","name":"Valiyaparamba","assemblyid":"139"},{"id":"570","name":"Vallachira","assemblyid":"78"},{"id":"452","name":"Vallapuzha","assemblyid":"89"},{"id":"493","name":"Vallatholenagar","assemblyid":"69"},{"id":"934","name":"Vallicode","assemblyid":"28"},{"id":"378","name":"Vallikkunnu","assemblyid":"106"},{"id":"893","name":"Vallikunnam","assemblyid":"39"},{"id":"727","name":"Vamanapuram","assemblyid":"12"},{"id":"1046","name":"Vandanmedu","assemblyid":"53"},{"id":"399","name":"Vandazhi","assemblyid":"81"},{"id":"1078","name":"Vandiperiyar","assemblyid":"51"},{"id":"271","name":"Vanimel","assemblyid":"118"},{"id":"460","name":"Vaniyamkulam","assemblyid":"90"},{"id":"1058","name":"Vannapuram","assemblyid":"52"},{"id":"568","name":"Varandarappilly","assemblyid":"78"},{"id":"40","name":"Varappetty","assemblyid":"59"},{"id":"67","name":"Varappuzha","assemblyid":"62"},{"id":"494","name":"Varavoor","assemblyid":"69"},{"id":"734","name":"Varkala","assemblyid":"13"},{"id":"542","name":"Vatanappally","assemblyid":"75"},{"id":"1069","name":"Vathikudy","assemblyid":"50"},{"id":"356","name":"Vattamkulam","assemblyid":"103"},{"id":"1033","name":"Vattavada","assemblyid":"49"},{"id":"744","name":"Vattiyoorkavu","assemblyid":"14"},{"id":"842","name":"Vayalar","assemblyid":"35"},{"id":"298","name":"Vazhakkad","assemblyid":"94"},{"id":"48","name":"Vazhakulam","assemblyid":"60"},{"id":"1006","name":"Vazhappally","assemblyid":"40"},{"id":"1063","name":"Vazhathope","assemblyid":"50"},{"id":"300","name":"Vazhayur","assemblyid":"94"},{"id":"333","name":"Vazhikkadavu","assemblyid":"99"},{"id":"1013","name":"Vazhoor","assemblyid":"43"},{"id":"928","name":"Vechoochira","assemblyid":"29"},{"id":"981","name":"Vechoor","assemblyid":"48"},{"id":"867","name":"Veeyapuram","assemblyid":"38"},{"id":"752","name":"Velinalloor","assemblyid":"15"},{"id":"791","name":"Veliyam","assemblyid":"21"},{"id":"866","name":"Veliyanad","assemblyid":"38"},{"id":"346","name":"Veliyankode","assemblyid":"101"},{"id":"601","name":"Vellamunda","assemblyid":"123"},{"id":"653","name":"Vellanad","assemblyid":"1"},{"id":"527","name":"Vellangallur","assemblyid":"73"},{"id":"718","name":"Vellarada","assemblyid":"10"},{"id":"1034","name":"Vellathooval","assemblyid":"49"},{"id":"1014","name":"Vellavoor","assemblyid":"43"},{"id":"461","name":"Vellinezhi","assemblyid":"90"},{"id":"1059","name":"Velliyamattom","assemblyid":"52"},{"id":"982","name":"Velloor","assemblyid":"48"},{"id":"968","name":"Vellyannoor","assemblyid":"42"},{"id":"259","name":"Velom","assemblyid":"117"},{"id":"512","name":"Velookkara","assemblyid":"71"},{"id":"535","name":"Velur","assemblyid":"74"},{"id":"700","name":"Vembayam","assemblyid":"7"},{"id":"114","name":"Vengad","assemblyid":"126"},{"id":"689","name":"Venganoor","assemblyid":"6"},{"id":"593","name":"Vengappally","assemblyid":"122"},{"id":"384","name":"Vengara","assemblyid":"107"},{"id":"75","name":"Vengola","assemblyid":"63"},{"id":"76","name":"Vengoor","assemblyid":"63"},{"id":"545","name":"Venkitangu","assemblyid":"75"},{"id":"903","name":"Venmony","assemblyid":"34"},{"id":"339","name":"Vettathur","assemblyid":"100"},{"id":"810","name":"Vettikkavala","assemblyid":"24"},{"id":"366","name":"Vettom","assemblyid":"104"},{"id":"741","name":"Vettoor","assemblyid":"13"},{"id":"992","name":"Vijayapuram","assemblyid":"44"},'
    //     '{"id":"816","name":"Vilakkudy","assemblyid":"24"},{"id":"677","name":"Vilappil","assemblyid":"4"},{"id":"678","name":"Vilavoorkkal","assemblyid":"4"},{"id":"453","name":"Vilayur","assemblyid":"89"},{"id":"261","name":"Villiappally","assemblyid":"117"},{"id":"651","name":"Vithura","assemblyid":"1"},{"id":"694","name":"Vizhinjam","assemblyid":"6"},{"id":"190","name":"Vorkady","assemblyid":"138"},{"id":"594","name":"Vythiri","assemblyid":"122"},{"id":"582","name":"Wadakkanchery","assemblyid":"80"},{"id":"392","name":"Wandoor","assemblyid":"108"},{"id":"742","name":"Wards No. 13, 15 to 25 & 31 to 36 of Tvpm (M. Corporation)","assemblyid":"14"},'
    //     '{"id":"199","name":"West Eleri","assemblyid":"139"},{"id":"807","name":"West Kallada","assemblyid":"23"}]}';

    // final response = await http.get(Uri.parse(newPanchaytApi));
    //
    // if (response.statusCode == 200) {
    //   Map<String, dynamic> data = json.decode(response.body);
    //   if(data['Status'].toString().toLowerCase()=='true'){
    //     AppData.Panchayt=response.body;
    //   }
    //
    //
    // } else {
    //   throw Exception('Failed to load items');
    // }
    return;
  }

  Future<void> checkthechallenge() async {
    // Log the API request being made
    print('Making POST request to $Challengeexist with body: {"version": ${AppData.versions[0].toString()}}');
    final response = await http.post(
      Uri.parse(Challengeexist),
      body: {"version": AppData.versions[0].toString()},
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        print(">>>>>the datas xxxxxxxxxx ${response.body}");

        if (parsedJson['Status'] == 'true') {
          AppData.ischallenge = true;

          AppData.challangeid = parsedJson['data'][0]['id'];
        } else {
          AppData.ischallenge = false;
        }
        Platform.isIOS
            ? AppData.hide = parsedJson['Appstorehiding'] ?? "0"
            : AppData.hide = "0";
        AppData.showdistrictandassembly =
            parsedJson['data'][0]['showdistrict_assembly'];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    //initConnectivity();

    checkthechallenge().then(
      (value) => fetchDistrictapi().then((value) {
        fetchAssemblyapi().then(
          (value) => fetchPanchaythapi().then(
            (value) => getDeviceId().then((value) => gotoHomepage()),
          ),
        );
      }),
    );

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Animation duration
    );

    // Define the slide animation from off-screen to the final position
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start from below the screen
      end: Offset(0.0, 0.0), // Final position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> callNativeMethod() async {
    const platform = MethodChannel("device/info");
    try {
      return await platform.invokeMethod("deviceId");
    } catch (e) {
      return 'nothing';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(24)),
              child: Container(
                width: 155,
                height: 155,
                child: Image.asset("assets/thennala/chthennala_logo.jpg"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ), // optional spacing from bottom
              child: Image.asset(
                "assets/StaticImg/footersplash.png",
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
