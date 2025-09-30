import 'dart:async';

import '../../../general_exports.dart';

class ReceptionController extends GetxController {
  late Timer _timer;

  Duration remainingTime = const Duration(minutes: 1);

  bool get isTimeUp => remainingTime.inSeconds <= 0;

  String get formattedTime {
    final String minutes = remainingTime.inMinutes.toString().padLeft(2, '0');
    final String seconds = (remainingTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime = remainingTime - const Duration(minutes: 1);
        update(); 
      } else {
        timer.cancel();
        update();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
