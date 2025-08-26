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
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
      'generalMedicineHeartDiseases': 'general_medicine_heart_diseases'.tr,
      'descriptionDoctor': 'description_doctor1'.tr,
      'address': 'title_address'.tr,
      'available_times': <Map<String, Object>>[
        <String, Object>{
          'day': 'السبت',
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
            <String, String>{'time': '2:00 - 3:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الاثنين',
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الأربعاء',
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الاثنين',
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الأربعاء',
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
      ],
    },
    <String, dynamic>{
      'id': 2,
      'image': imageDoctor,
      'name': 'name_doctor2'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
      'generalMedicineHeartDiseases': 'general_specialization_with_minor'.tr,
      'descriptionDoctor': 'description_doctor2'.tr,
      'address': 'title_address1'.tr,
      'available_times': <Map<String, Object>>[
        <String, Object>{
          'day': 'الأحد',
          'times': <Map<String, String>>[
            <String, String>{'time': '10:00 - 2:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الثلاثاء',
          'times': <Map<String, String>>[
            <String, String>{'time': '3:00 - 7:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الخميس',
          'times': <Map<String, String>>[
            <String, String>{'time': '9:00 - 1:00 مساءً'},
          ],
        },
      ],
    },
    <String, dynamic>{
      'id': 3,
      'image': imageDoctor,
      'name': 'name_doctor3'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'reveal': 'detection_times'.tr,
      'skills': <String>['مستمع جيد', 'ودود', 'مستمع جيد'],
      'salary': '200 ج',
      'generalMedicineHeartDiseases': 'general_medicine_neurology'.tr,
      'descriptionDoctor': 'description_doctor3'.tr,
      'address': 'title_address2'.tr,
      'available_times': <Map<String, Object>>[
        <String, Object>{
          'day': 'الجمعة',
          'times': <Map<String, String>>[
            <String, String>{'time': '12:00 - 4:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'السبت',
          'times': <Map<String, String>>[
            <String, String>{'time': '5:00 - 9:00 مساءً'},
          ],
        },
        <String, Object>{
          'day': 'الأربعاء',
          'times': <Map<String, String>>[
            <String, String>{'time': '8:00 - 12:00 مساءً'},
          ],
        },
      ],
    },
  ];
}
