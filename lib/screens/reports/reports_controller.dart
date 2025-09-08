import '../../general_exports.dart';

class ReportsController extends GetxController {
  int isSelected = 0;
  final double widthSelected = DEVICE_WIDTH <= 380 ? 0.45 : 0.48;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;
  RxList<String> heHasExperienceIn = <String>[].obs;
  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;

  final List<String> tabs = <String>[
    'prescriptions'.tr,
    'the_radiology'.tr,
    'analyses'.tr,
  ];

  double calculateWidth(String text) {
    return text.length * 3 + 1;
  }

  List doctors = <dynamic>[
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
  ];
}
