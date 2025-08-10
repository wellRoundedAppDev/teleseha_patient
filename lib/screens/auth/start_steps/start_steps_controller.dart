import 'dart:async';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentSteps = 1;
  String? selectedMaleCode = 'male';
  TextEditingController TextfieldAge = TextEditingController();
  TextEditingController TextfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController TextfieldChronicDiseases = TextEditingController();
  TextEditingController TextfieldSurgicalOperations = TextEditingController();
  TextEditingController TextfieldContinuousMedications =
      TextEditingController();
  TextEditingController TextfieldAllergies = TextEditingController();

  bool isVaildAge = false;
  bool isVaildName = false;
  bool isVaildNumber = false;
  bool isOtpInvalid = false;

  bool isVaildChronicDiseases = false;
  bool isVaildSurgicalOperations = false;
  bool isVaildContinuousMedications = false;
  bool isVaildAllergies = false;

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

  bool checkAllVaildsSteps() {
    bool isValid = true;

    if (currentSteps == 1) {
      if (TextfieldAge.text.isEmpty) {
        isVaildAge = true;
        isValid = false;
      } else {
        isVaildAge = false;
      }
    }

    if (currentSteps == 2) {
      if (TextfieldName.text.isEmpty && TextfieldNumber.text.isEmpty) {
        isValid = false;
      }

      if (TextfieldName.text.isEmpty) {
        isVaildName = true;
        isValid = false;
      } else {
        isVaildName = false;
      }

      if (TextfieldNumber.text.isEmpty) {
        isVaildNumber = true;
        isValid = false;
      } else {
        isVaildNumber = false;
      }
    }

    if (currentSteps == 3) {
      if (TextfieldChronicDiseases.text.isEmpty) {
        isVaildChronicDiseases = true;
        isValid = false;
      } else {
        isVaildChronicDiseases = false;
      }
      if (TextfieldSurgicalOperations.text.isEmpty) {
        isVaildSurgicalOperations = true;
        isValid = false;
      } else {
        isVaildSurgicalOperations = false;
      }
      if (TextfieldContinuousMedications.text.isEmpty) {
        isVaildContinuousMedications = true;
        isValid = false;
      } else {
        isVaildContinuousMedications = false;
      }
      if (TextfieldAllergies.text.isEmpty) {
        isVaildAllergies = true;
        isValid = false;
      } else {
        isVaildAllergies = false;
      }
    }

    if (isValid) {
      if (currentSteps == 3) {
        consoleLog(
          "age: ${TextfieldAge.text}, name: ${TextfieldName.text}, , number: ${TextfieldNumber.text}",
        );
      }
    }
    update();
    return isValid;
  }

  // This is the otp timer logic
  // create request post and data user and save storage to data user
  void checkOtp() {
    if (currentSteps == 4) {
      if (!checkOtpIsValid()) {
        markOtpInvalid();
      } else {
        clearOtpError();
        consoleLog("OTP Entered: ${otpController.text}");
        Get.toNamed(routeCreateAccountSuccess);
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
    consoleLog("تمت إعادة إرسال الكود");
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
    consoleLog("انتهى الوقت");
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
    consoleLog("📥 OTP Entered: ${otpController.text}");
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
