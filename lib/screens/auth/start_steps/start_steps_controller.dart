import 'dart:async';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentSteps = 1;
  int numberOfAllSteps = 4;
  bool use_biometric = false;
  String? selectedMaleCode = 'male';
  TextEditingController TextfieldAge = TextEditingController();
  TextEditingController TextfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();
  TextEditingController TextfieldPassword = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  // TextEditingController TextfieldChronicDiseases = TextEditingController();
  // TextEditingController TextfieldSurgicalOperations = TextEditingController();
  // TextEditingController TextfieldContinuousMedications =
  //     TextEditingController();
  // TextEditingController TextfieldAllergies = TextEditingController();

  bool isVaildAge = false;
  bool isVaildName = false;
  bool isVaildNumber = false;
  bool isVaildPassword = false;
  bool isOtpInvalid = false;

  // bool isVaildChronicDiseases = false;
  // bool isVaildSurgicalOperations = false;
  // bool isVaildContinuousMedications = false;
  // bool isVaildAllergies = false;

  int secondsRemaining = 70;
  Timer? timer;

  List<Map<String, String>> typeGenrate = [
    {gender: 'female'.tr, icon: iconFemale, code: 'female'},
    {gender: 'male'.tr, icon: iconMale, code: 'male'},
  ];

  void minuseSelectedSteps() {
    currentSteps--;
    update();
  }

  void changeTypeGenrate(String typeCode) {
    selectedMaleCode = typeCode;
    update();
  }

  Future<void> checkBiometrics() async {
    final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
    if (!canAuthenticateWithBiometrics) {
      Fluttertoast.showToast(msg: 'Devices is not supoprt biometrics');
      return;
    }

    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      Fluttertoast.showToast(
        msg:
            'Biometrics is empty, please set up Biometrics in devices settings',
      );
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'please_auth_finger_print'.tr,
      );
      if (didAuthenticate) {
        use_biometric = true;
        currentSteps++;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
    }
  }

  bool checkAllVaildsSteps() {
    bool isValid = true;

    if (currentSteps == 2) {
      if (TextfieldName.text.isEmpty && TextfieldAge.text.isEmpty) {
        isValid = false;
      }

      if (TextfieldName.text.isEmpty) {
        isVaildName = true;
        isValid = false;
      } else {
        isVaildName = false;
      }

      if (TextfieldAge.text.isEmpty) {
        isVaildAge = true;
        isValid = false;
      } else {
        isVaildAge = false;
      }
    }

    if (currentSteps == 3) {
      if (TextfieldNumber.text.isEmpty && TextfieldPassword.text.isEmpty) {
        isValid = false;
      }

      if (TextfieldNumber.text.isEmpty) {
        isVaildPassword = true;
        isValid = false;
      } else {
        isVaildPassword = false;
      }

      if (TextfieldPassword.text.isEmpty) {
        isVaildNumber = true;
        isValid = false;
      } else {
        isVaildNumber = false;
      }
    }

    if (currentSteps == 4) {
      if (!checkOtpIsValid()) {
        isValid = false;
        markOtpInvalid();
      } else {
        Get.toNamed(routeCreateAccountSuccess);
        clearOtpError();
        consoleLog('OTP Entered: ${otpController.text}');
      }
    }

    update();
    return isValid;
  }

  // bool dedical_history() {
  //   bool isValid = true;

  //   if (TextfieldChronicDiseases.text.isEmpty) {
  //     isVaildChronicDiseases = true;
  //     isValid = false;
  //   } else {
  //     isVaildChronicDiseases = false;
  //   }

  //   if (TextfieldSurgicalOperations.text.isEmpty) {
  //     isVaildSurgicalOperations = true;
  //     isValid = false;
  //   } else {
  //     isVaildSurgicalOperations = false;
  //   }

  //   if (TextfieldContinuousMedications.text.isEmpty) {
  //     isVaildContinuousMedications = true;
  //     isValid = false;
  //   } else {
  //     isVaildContinuousMedications = false;
  //   }

  //   if (TextfieldAllergies.text.isEmpty) {
  //     isVaildAllergies = true;
  //     isValid = false;
  //   } else {
  //     isVaildAllergies = false;
  //   }

  //   update();
  //   return isValid;
  // }

  // This is the otp timer logic
  // create request post and data user and save storage to data user

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
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    final minutes = secondsRemaining ~/ 60;
    final secs = secondsRemaining % 60;
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
    isOtpInvalid = true;
    update();
  }

  void clearOtpError() {
    isOtpInvalid = false;
    update();
  }

  bool checkOtpIsValid() {
    return otpController.text.length == 6;
  }
}
