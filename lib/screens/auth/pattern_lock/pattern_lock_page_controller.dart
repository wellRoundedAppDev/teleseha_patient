import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class PatternLockPageController extends GetxController {
  // this array for api
  final List<int> passPattern = <int>[0, 1, 2, 3, 4];
  List<int> patterns = <int>[];
  PatternState state = PatternState.active;
  int _patternAttemptId = 0;

  // check user if userdata is success save userdata to localstorage true go to the home page

  void showValidPattern() {
    final int currentAttempt = ++_patternAttemptId;
    if (listEquals(passPattern, patterns)) {
      state = PatternState.success;
      update();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.toNamed(routeSteps);
      });
    } else {
      state = PatternState.error;
      update();
      Future.delayed(const Duration(seconds: 3), () {
        if (currentAttempt == _patternAttemptId) {
          state = PatternState.normal;
          patterns = <int>[];
          update();
        }
      });
    }
    update();
  }
}
