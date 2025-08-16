import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class LoginController extends GetxController {
  final TextEditingController textFieldPhoneNumber = TextEditingController();

  final StartStepsController startStepsController = Get.put(
    StartStepsController(),
  );

  bool showPhoneNumberError = false;
  double argumentValue = 0.0;

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
      argumentValue = 0.6;
      Get.to(PatternLock());
      update();
    } else {
      Get.toNamed(routeSteps);
    }
    return true;
  }

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

    debugPrint('Input Pattern: $inputPattern');
    debugPrint('Expected Pattern: $passPattern');

    if (listEquals(passPattern, inputPattern)) {
      state = PatternState.success;
      update();
      Get.snackbar(
        '✅ Success',
        'Pattern: $inputPattern',
        backgroundColor: const Color(AppColors.colorSuccessLine),
        colorText: const Color(0xFFFFFFFF),
      );
      Get.toNamed(routeLoginAboutHow);
    } else {
      state = PatternState.error;
      update();

      showForgetPatter = true;

      Future.delayed(const Duration(seconds: 2), () {
        if (currentAttempt == attemptId) {
          resetPattern();
        }
      });
    }
  }

  void startPattern() {
    if (state == PatternState.error || state == PatternState.success) {
      resetPattern();
    } else {
      state = PatternState.active;
      update();
    }
  }

  void inputPatternWhenClick() {
    consoleLog('User pattern input: $inputPattern');
    update();
  }

  // create verification for existingUser about user
  void createVerificationForExistingUser() {
    consoleLog('true');
  }

  bool checkFunctionRegiserOrSignIn() {
    final String? argument = startStepsController.argumentValue;
    if (argument != '/pattern-lock') {
      return startStepsController.checkSignInOrSignUp = true;
    } else {
      return startStepsController.checkSignInOrSignUp = false;
    }
  }
}
