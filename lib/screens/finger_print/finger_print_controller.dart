import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../general_exports.dart';

class FingerPrintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> checkUserAndNavigate() async {
    final bool userData = false;
    // ignore: dead_code
    userData ? Get.toNamed(routeHome) : Get.toNamed(routeSteps);
  }

  Future<void> startBiometricAuth() async {
    final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
    if (!canAuthenticateWithBiometrics) {
      Fluttertoast.showToast(msg: 'not_support'.tr);
      return;
    }

    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      Fluttertoast.showToast(msg: 'piometrics_empty'.tr);
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'please_auth_finger_print'.tr,
      );
      if (didAuthenticate) {
        // check userdata about check route steps
        checkUserAndNavigate();
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
    }
  }
}
