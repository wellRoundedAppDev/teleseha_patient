import '../../general_exports.dart';

class DoctorsController extends GetxController {
  TextEditingController filterDoctors = TextEditingController();
  bool showDoctors = false;

  final double widthSelected = DEVICE_WIDTH <= 380 ? 300 : 400;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;

  bool selectedGeneralOrSpecializedMajor = true;

  int? passedIndex = 0;

  List<Map<String, dynamic>> doctors = <Map<String, dynamic>>[
    <String, dynamic>{
      'image': imageDoctor,
      'name': 'name_doctor'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': '(85 مرات الكشف)',
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
    },
    <String, dynamic>{
      'image': imageDoctor,
      'name': 'name_doctor'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': '(85 مرات الكشف)',
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
    },
    <String, dynamic>{
      'image': imageDoctor,
      'name': 'name_doctor'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': '(85 مرات الكشف)',
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
    },
  ];
}
