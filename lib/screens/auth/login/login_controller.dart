import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class LoginController extends GetxController {
  final TextEditingController textFieldPhoneNumber = TextEditingController();
  List<int> tempSavedPattern = <int>[];

  String pageResolution = 'signIn';

  bool showPhoneNumberError = false;
  double argumentValue = 0.0;

  // check pass about data if true open the user and open response users and loop to users and view to list view
  final List<int> passPattern = <int>[0, 1, 2, 3, 4];
  List<int> inputPattern = <int>[];
  PatternState state = PatternState.normal;
  int attemptId = 0;
  bool showForgetPatter = false;

  // check pass about data if true open the user and open response users and loop to users and view to list view
  final List<Map<String, dynamic>> usersIntegrate = <Map<String, dynamic>>[
    <String, dynamic>{'id': 1, 'icon': iconUser, 'name': 'name_user'.tr},
    <String, dynamic>{'id': 2, 'icon': iconUser, 'name': 'name_user_tow'.tr},
    <String, dynamic>{'id': 3, 'icon': iconUser, 'name': 'name_user'.tr},
    <String, dynamic>{'id': 4, 'icon': iconUser, 'name': 'name_user_tow'.tr},
    <String, dynamic>{'id': 5, 'icon': iconUser, 'name': 'name_user'.tr},
    <String, dynamic>{'id': 6, 'icon': iconUser, 'name': 'name_user_tow'.tr},
    <String, dynamic>{'id': 7, 'icon': iconUser, 'name': 'name_user_tow'.tr},
    <String, dynamic>{'id': 8, 'icon': iconUser, 'name': 'name_user'.tr},
    <String, dynamic>{'id': 9, 'icon': iconUser, 'name': 'name_user_tow'.tr},
    <String, dynamic>{'id': 10, 'icon': iconUser, 'name': 'name_user'.tr},
    <String, dynamic>{'id': 11, 'icon': iconUser, 'name': 'name_user_tow'.tr},
  ];

  void updatePageResolution(String newResolution) {
    pageResolution = newResolution;
    update();
  }

  bool handleLogin() {
    if (textFieldPhoneNumber.text.isEmpty) {
      showPhoneNumberError = true;
      update();
      return false;
    }
    showPhoneNumberError = false;
    update();
    // check request if textfield phone number true open route pattern lock else open route steps
    if (textFieldPhoneNumber.text == '222') {
      argumentValue = 0.6;
      pageResolution = 'signIn';
      Get.to(() => PatternLock());
      update();
      textFieldPhoneNumber.clear();
    } else {
      updatePageResolution('signUp');
      Get.toNamed(routeSteps);
      textFieldPhoneNumber.clear();
    }
    return true;
  }

  void resetPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();
  }

  void updatePattern(List<int> pattern) {
    inputPattern = pattern;
  }

  // check pattern if pattern success open routeLoginAboutHow false make show forget patter true
  void validatePattern() {
    final int currentAttempt = ++attemptId;

    consoleLog('Input Pattern: $inputPattern');
    consoleLog('Expected Pattern: $passPattern');
    consoleLog('state: $state');

    if (listEquals(passPattern, inputPattern)) {
      state = PatternState.success;
      update();
      Get.snackbar(
        '✅ Success',
        'Pattern: $inputPattern',
        backgroundColor: const Color(AppColors.colorSuccessLine),
        colorText: const Color(0xFFFFFFFF),
      );
      resetPattern();
    } else {
      state = PatternState.error;
      update();

      showForgetPatter = true;

      // ignore: always_specify_types
      Future.delayed(const Duration(seconds: 2), () {
        if (currentAttempt == attemptId) {
          resetPattern();
        }
      });
    }
  }

  // create verification for existingUser about user
  void createVerificationForExistingUser() {
    if (pageResolution == 'update') {
      if (inputPattern.isNotEmpty) {
        tempSavedPattern = <int>[...inputPattern];
        resetPattern();
        updatePageResolution('verifyPattern');
        state = PatternState.success;
        update();
      } else {
        Get.snackbar(
          'error'.tr,
          'error_pattern'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else if (pageResolution == 'verifyPattern') {
      if (listEquals(tempSavedPattern, inputPattern)) {
        state = PatternState.success;
        update();
        consoleLog(tempSavedPattern);
        pageResolution = 'signIn';
        Get.toNamed(routeLoginAboutHow);
      } else {
        state = PatternState.error;
        update();
        Get.snackbar(
          'error'.tr,
          'error_pattern'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        updatePageResolution('update');
      }
    }
  }

  void startPattern() {
    if (state == PatternState.error || state == PatternState.success) {
      inputPattern.clear();
      state = PatternState.normal;
    }
    state = PatternState.active;
    update();
  }
}
