import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../general_exports.dart';

class FingerPrintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  LocalStorage localStorage = LocalStorage();
  String? refreshToken;
  final StartStepsController stepController = Get.find();

  Future<void> checkUserAndNavigate() async {
    refreshToken = await localStorage.readFromStorage(storageRefreshToken);
    if (refreshToken != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(routeSteps);
        stepController.currentStep = 3;
      });
    } else {
      Get.offAllNamed(routeLogin);
    }
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
      final bool isAuthenticated = await auth.authenticate(
        localizedReason: 'please_auth_finger_print'.tr,
      );
      if (isAuthenticated) {
        // check userdata about check route steps
        checkUserAndNavigate();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
    }
  }
}
