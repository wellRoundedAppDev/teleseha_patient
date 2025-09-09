import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentStep = 1;
  int numberOfStep = 3;
  String? selectedMaleCode = 'male';
  bool? checkSignInOrSignUp = false;
  final bool isSignIn = false;
  List<int> tempSavedPattern = <int>[];
  List<int> inputPattern = <int>[];

  TextEditingController otpController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  LocalStorage localStorage = LocalStorage();

  LoginController login = Get.find();

  bool showPhoneNumberError = false;
  bool showOtpError = false;
  bool showNameError = false;
  bool showdateControllerError = false;

  int secondsRemaining = 70;
  Timer? timer;

  final List<int> passPattern = <int>[0, 1, 2, 3, 4];
  List<int> patterns = <int>[];
  PatternState state = PatternState.normal;

  List<Map<String, String>> typeGenerate = <Map<String, String>>[
    <String, String>{gender: 'female'.tr, icon: iconFemale, code: 'female'},
    <String, String>{gender: 'male'.tr, icon: iconMale, code: 'male'},
  ];

  @override
  void onReady() {
    super.onReady();
    startCountdown();
  }

  void minusSelectedSteps() {
    currentStep--;
    update();
  }

  void changeTypeGenerate(String typeCode) {
    selectedMaleCode = typeCode;
    update();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate = picked;
      final String formattedDate =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
      dateController.text = formattedDate;
      update();
    } else {
      consoleLog('❌ Date picker dismissed');
    }
  }

  bool canGoToStepOtp() {
    showNameError = textFieldName.text.isEmpty;
    showdateControllerError = dateController.text.isEmpty;
    consoleLog(textFieldName.text + dateController.text);
    update();
    return !showNameError && !showdateControllerError;
  }

  bool checkOtp() {
    if (!isValidOtpIsValid()) {
      markOtpInvalid();
      return false;
    } else {
      clearOtpError();
      consoleLog('OTP Entered: ${otpController.text}');
      return true;
    }
  }

  // request otp confirm
  void checkOtpToNextPage() {
    if (checkOtp()) {
      final LoginController controller = Get.find<LoginController>();
      if (controller.page == 'signIn') {
        // if nextAction create password open patternLock and update page
        consoleLog('${login.phoneNumberController.text} ${otpController.text}');
        controller.updatePage('update');
        otpController.clear();
        Get.to(() => PatternLock());
        update();
        controller.resetPattern();
        consoleLog(otpController);
      } else if (controller.page == 'signUp') {
        controller.updatePage('signUp');
        otpController.clear();
        update();
        controller.resetPattern();
        consoleLog(otpController);
        Get.toNamed(routeSteps);
      }
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

  void updatePattern(List<int> pattern) {
    inputPattern = pattern;
    update();
  }

  void resetPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();
  }

  // create pattern
  bool canGoToStepTwo(List<int> pattern) {
    if (pattern.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'error_pattern'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (tempSavedPattern.isEmpty) {
      // ignore: always_specify_types
      tempSavedPattern = List.from(pattern);
      state = PatternState.success;
      update();
      return true;
    } else {
      // ignore: always_specify_types
      inputPattern = List.from(pattern);
      if (listEquals(inputPattern, tempSavedPattern)) {
        state = PatternState.success;
        update();
        return true;
      } else {
        state = PatternState.error;
        update();
        Get.snackbar(
          'error'.tr,
          'error_pattern'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    }
  }

  void onNextButtonPress() {
    if (currentStep == 1) {
      if (canGoToStepTwo(inputPattern)) {
        resetPattern();
        currentStep++;
        update();
      }
    } else if (currentStep == 2) {
      if (canGoToStepOtp()) {
        Get.toNamed(routeFormDiagnosis);
        update();
      }
    }
  }

  void restartTimer() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final int minutes = secondsRemaining ~/ 60;
    final int secs = secondsRemaining % 60;
    return '[$minutes:${secs.toString().padLeft(2, '0')}]';
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    otpController.dispose();
  }

  void consoleLogOtp() {
    consoleLog('📥 OTP Entered: ${otpController.text}');
  }

  void markOtpInvalid() {
    showOtpError = true;
    update();
  }

  void clearOtpError() {
    showOtpError = false;
    update();
  }

  bool isValidOtpIsValid() {
    return otpController.text.length == 6;
  }
}
