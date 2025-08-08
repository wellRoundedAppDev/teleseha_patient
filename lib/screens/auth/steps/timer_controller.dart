import 'dart:async';
import 'package:patient/general_exports.dart';

class TimerController extends GetxController {
  int secondsRemaining = 70;
  TextEditingController otpController = TextEditingController();
  Timer? _timer;
  bool isOtpInvalid = false;

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
  }

  void startTimerManually() {
    _timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void restartTimer() {
    _timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
    print("تمت إعادة إرسال الكود");
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    print("انتهى الوقت");
  }

  String get formattedTime {
    final minutes = secondsRemaining ~/ 60;
    final secs = secondsRemaining % 60;
    return '[$minutes:${secs.toString().padLeft(2, '0')}]';
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    otpController.dispose();
  }

  void printOtp() {
    print("📥 OTP Entered: ${otpController.text}");
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
