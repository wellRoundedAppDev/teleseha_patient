import 'package:get/get.dart';

class Mypagecontroller extends GetxController {
  bool isToggled = true;

  void toggleSwitch(bool value) {
    isToggled = value;
    update();
  }
}
