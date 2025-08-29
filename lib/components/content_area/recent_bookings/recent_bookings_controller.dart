import 'dart:async';

import '../../../general_exports.dart';

class RecentBookingsController extends GetxController {
  int? passedIndex = 0;
  int? get selectedRecentBookingsId => passedIndex;
  // ignore: always_specify_types
  Map? selectedLastRecent;
  int currentStep = 0;
  final int totalSteps = 5;
  int remainingMinutes = 1;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      remainingMinutes > 0 ? remainingMinutes-- : timer.cancel();
      remainingMinutes == 10 || remainingMinutes == 0 ? currentStep = 2 : null;
      update();
    });
  }

  // ignore: always_specify_types
  List lastRecent = <dynamic>[
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },
    <String, Object>{
      'id': 2,
      'image': imageDoctor,
      'name': 'name_doctor2'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },
    <String, Object>{
      'id': 3,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },

    <String, Object>{
      'id': 4,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },
    <String, Object>{
      'id': 5,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },
    <String, Object>{
      'id': 6,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'date': 'accosts'.tr,
      'time': '2:00',
    },
  ];

  void selectedLastRecentFunction() {
    selectedLastRecent = lastRecent.firstWhere(
      // ignore: non_constant_identifier_names, always_specify_types
      (LastRecent) => LastRecent['id'] == selectedRecentBookingsId,
      orElse: () => <dynamic, dynamic>{},
    );
  }
}
