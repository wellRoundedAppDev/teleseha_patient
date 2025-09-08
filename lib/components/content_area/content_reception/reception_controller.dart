import 'dart:async';

import '../../../general_exports.dart';

class ReceptionController extends GetxController {
  late Timer _timer;

  Duration remainingTime = const Duration(minutes: 1);

  bool get isTimeUp => remainingTime.inSeconds <= 0;

  String get formattedTime {
    final minutes = remainingTime.inMinutes.toString().padLeft(2, '0');
    final seconds = (remainingTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime = remainingTime - const Duration(minutes: 1);
        update(); 
      } else {
        timer.cancel();
        onTimerComplete();
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
