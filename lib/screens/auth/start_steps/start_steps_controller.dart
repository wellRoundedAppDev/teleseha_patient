import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentStep = 1;
  int numberOfStep = 3;
  bool useBiometric = false;
  String? selectedMaleCode = 'male';

  TextEditingController textFieldPhoneNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  bool showPhoneNumberError = false;
  bool showOtpError = false;
  bool showNameError = false;
  bool showdateControllerError = false;

  int secondsRemaining = 70;
  Timer? timer;

  List<Map<String, String>> typeGenerate = <Map<String, String>>[
    <String, String>{gender: 'female'.tr, icon: iconFemale, code: 'female'},
    <String, String>{gender: 'male'.tr, icon: iconMale, code: 'male'},
  ];

  void minusSelectedSteps() {
    currentStep--;
    update();
  }

  void changeTypeGenerate(String typeCode) {
    selectedMaleCode = typeCode;
    update();
  }

  Future<void> checkBiometrics() async {
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
        useBiometric = true;
        Get.toNamed(routeSteps);
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
    }
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
  bool canGoToStepTwo() {
    showPhoneNumberError = textFieldPhoneNumber.text.isEmpty;
    update();
    return !showPhoneNumberError;
  }

  bool canGoToStepThree() {
    if (!isValidOtpIsValid()) {
      timer?.cancel();
      markOtpInvalid();
      return false;
    } else {
      clearOtpError();
      consoleLog('OTP Entered: ${otpController.text}');
      return true;
    }
  }

  bool canGoToCreateSuccessPage() {
    showNameError = textFieldName.text.isEmpty;
    showdateControllerError = dateController.text.isEmpty;
    update();
    return !showNameError && !showdateControllerError;
  }

  void onNextButtonPress() {
    if (currentStep == 1) {
      // here save response true or false
      if (canGoToStepTwo()) {
        ++currentStep;
        consoleLog(textFieldPhoneNumber.text);
        update();
      }
    }
    // post otp
    // get response userdata if true open homepage if false open register
    // save userdata in localstorage
    else if (currentStep == 2) {
      if (canGoToStepThree()) {
        ++currentStep;
        consoleLog(otpController.text);
        clearOtpError();
        update();
      } else {
        markOtpInvalid();
        update();
      }
    }
    // check userdata if response true open create account success else print error
    else if (currentStep == 3) {
      if (canGoToCreateSuccessPage()) {
        Get.toNamed(routeCreateAccountSuccess);
        consoleLog(
          '${textFieldName.text}, ${dateController.text}, $selectedMaleCode',
        );

        textFieldPhoneNumber.clear();
        otpController.clear();
        textFieldName.clear();
        dateController.clear();
        update();
      }
    }
  }

  void startTimerManually() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void restartTimer() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
    consoleLog('تمت إعادة إرسال الكود');
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        update();
      } else {
        timer.cancel();
        onTimeFinished();
      }
    });
  }

  void onTimeFinished() {
    consoleLog('انتهى الوقت');
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
