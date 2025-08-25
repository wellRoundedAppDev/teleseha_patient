import 'dart:async';

import '../../../general_exports.dart';

class ReceptionController extends GetxController {
  late Timer _timer;
  Duration remainingTime = const Duration(minutes: 20);

  String get formattedTime {
    final String minutes = remainingTime.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final String seconds = remainingTime.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime = remainingTime - const Duration(seconds: 1);
        update();
      } else {
        onTimerComplete();
        remainingTime = const Duration(minutes: 1);
        update();
      }
    });
  }

  void onTimerComplete() {
    print('Timer finished! Event triggered.');
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
