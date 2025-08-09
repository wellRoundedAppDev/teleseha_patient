import 'dart:async';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int selectedSteps = 1;
  String? selected;
  TextEditingController TextfieldAge = TextEditingController();
  TextEditingController TextfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool viewVaildType = false;
  bool viewVaildAge = false;
  bool viewVaildName = false;
  bool viewVaildNumber = false;
  bool viewOtpInvalid = false;

  int secondsRemaining = 70;
  Timer? timer;

  List<Map<String, String>> type = [
    {'gender': 'female'.tr, 'icon': iconFemale},
    {'gender': 'male'.tr, 'icon': iconMale},
  ];

  minuseSelectedSteps() {
    selectedSteps--;
    update();
  }

  changeType(type) {
    selected = type;
    viewVaildType = false;
    update();
  }

  bool checkAllVailds() {
    bool isValid = true;

    if (selectedSteps == 1) {
      if (TextfieldAge.text.isEmpty) {
        viewVaildAge = true;
        isValid = false;
      } else {
        viewVaildAge = false;
      }
    }

    if (selectedSteps == 2) {
      if (TextfieldName.text.isEmpty && TextfieldNumber.text.isEmpty) {
        isValid = false;
      }

      if (TextfieldName.text.isEmpty) {
        viewVaildName = true;
        isValid = false;
      } else {
        viewVaildName = false;
      }

      if (TextfieldNumber.text.isEmpty) {
        viewVaildNumber = true;
        isValid = false;
      } else {
        viewVaildNumber = false;
      }
    }

    if (selected == null) {
      viewVaildType = true;
      isValid = false;
    } else {
      viewVaildType = false;
    }

    if (isValid) {
      if (selectedSteps == 2) {
        consoleLog(
          "type: ${selected}, age: ${TextfieldAge.text}, name: ${TextfieldName.text}, , number: ${TextfieldNumber.text}",
        );
      }
    }
    update();
    return isValid;
  }

  // This is the otp timer logic
  // create request post and data user and save storage to data user
  void checkOtp() {
    if (selectedSteps == 3) {
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
    viewOtpInvalid = true;
    update();
  }

  void clearOtpError() {
    viewOtpInvalid = false;
    update();
  }

  bool checkOtpIsValid() {
    return otpController.text.length == 6;
  }
}
