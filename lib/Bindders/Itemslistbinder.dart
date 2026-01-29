import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:chcenterthennala/controller/Sponsorshipcontroller.dart';

class ItemlistBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(Sponsorshipcontroller());
  }
}
