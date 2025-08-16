import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentStep = 1;
  int numberOfStep = 4;
  String? selectedMaleCode = 'male';
  // String? argumentValue;
  bool? checkSignInOrSignUp = false;
  final bool isSignIn = false;
  List<int> tempSavedPattern = <int>[];
  List<int> inputPattern = <int>[];

  TextEditingController textFieldPhoneNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();

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

  // create request number one or can go to step tow
  // bool canGoToStepTwo() {
  //   showPhoneNumberError = textFieldPhoneNumber.text.isEmpty;
  //   consoleLog(textFieldPhoneNumber.text);
  //   update();
  //   return !showPhoneNumberError;
  // }

  // bool canGoToStepFour() {
  //   showNameError = textFieldName.text.isEmpty;
  //   showdateControllerError = dateController.text.isEmpty;
  //   consoleLog(textFieldName.text + dateController.text);
  //   update();
  //   return !showNameError && !showdateControllerError;
  // }

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

  void checkOtpToNextPage() {
    if (checkOtp()) {
      final LoginController controller = Get.find<LoginController>();
      controller.updatePageResolution('update');
      if (controller.pageResolution == 'update') {
        otpController.clear();
        Get.to(() => PatternLock());
        update();
        consoleLog(otpController);
      }
      update();
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
  }

  // void setArgument(String? value) {
  //   if (checkOtp()) {
  //     argumentValue = value;
  //     update();
  //   }
  // }

  // void resetSignInOrRegister() {
  //   checkSignInOrSignUp = null;
  //   // argumentValue = null;
  //   update();
  // }

  void resetPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();
  }

  // create pattern
  bool canGoToStepTwo(List<int> pattern) {
    consoleLog(pattern);
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
      tempSavedPattern = List.from(pattern);
      state = PatternState.success;
      update();
      return true;
    } else {
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
    }

    // else if (currentStep == 2) {
    // canGoToStepThree();
    // } else if (currentStep == 3) {
    //   if (canGoToStepFour()) {
    //     ++currentStep;
    //     consoleLog(otpController.text);
    //     clearOtpError();
    //     update();
    //   } else {
    //     markOtpInvalid();
    //     update();
    //   }
    // }
    // post request otp
    // check if otp in register open create account success
    // if otp in error pattern open new pattern
    // else if (currentStep == numberOfStep) {
    //   if (canGoToCreateSuccessPage()) {
    //     Get.toNamed(routeCreateAccountSuccess);
    //     consoleLog(
    //       '${textFieldName.text}, ${dateController.text}, $selectedMaleCode',
    //     );

    //     textFieldPhoneNumber.clear();
    //     otpController.clear();
    //     textFieldName.clear();
    //     dateController.clear();
    //     update();
    //   }
    // }
    // save userdata in localstorage
  }

  void restartTimer() {
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void startCountdown() {
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
