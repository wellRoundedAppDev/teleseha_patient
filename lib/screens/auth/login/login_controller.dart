import '../../../general_exports.dart';

class LoginController extends GetxController {
  final TextEditingController textFieldPhoneNumber = TextEditingController();

  bool showPhoneNumberError = false;

  bool handleLogin() {
    if (textFieldPhoneNumber.text.isEmpty) {
      showPhoneNumberError = true;
      update();
      return false;
    }
    showPhoneNumberError = false;
    update();
    // check request if textfieldphonenumber true open routepatternlock else open routesteps
    if (textFieldPhoneNumber.text == '222') {
      Get.toNamed(routePatternLock);
    } else {
      Get.toNamed(routeSteps);
    }
    return true;
  }
}
