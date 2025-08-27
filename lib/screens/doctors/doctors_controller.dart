import '../../general_exports.dart';

class DoctorsController extends GetxController {
  TextEditingController filterDoctors = TextEditingController();
  bool showDoctors = false;

  final double widthSelected = DEVICE_WIDTH <= 380 ? 300 : 400;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;

  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;
  // ignore: always_specify_types
  Map? selectedDoctor;

  RxList<Map<String, dynamic>> availableTimes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> qualifications = <Map<String, dynamic>>[].obs;
  RxList<String> heHasExperienceIn = <String>[].obs;
  RxList<String> clinicalExperience = <String>[].obs;

  bool selectedGeneralOrSpecializedMajor = true;

  int isSelected = 0;

  void selectedDoctorFunction() {
    selectedDoctor = doctors.firstWhere(
      // ignore: always_specify_types
      (doctor) => doctor['id'] == selectedDoctorId,
      orElse: () => <dynamic, dynamic>{},
    );

    availableTimes.value = List<Map<String, dynamic>>.from(
      selectedDoctor?['available_times'] ?? <dynamic>[],
    );
    qualifications.value = List<Map<String, dynamic>>.from(
      selectedDoctor?['qualifications'] ?? <dynamic>[],
    );
    heHasExperienceIn.value = List<String>.from(
      selectedDoctor?['practicalExperienceIn'] ?? <dynamic>[],
    );
    clinicalExperience.value = List<String>.from(
      selectedDoctor?['clinicalExperience'] ?? <dynamic>[],
    );
  }

  final List<String> tabs = <String>[
    'practical_experiments'.tr,
    'education'.tr,
    'ratings'.tr,
  ];

  // ignore: always_specify_types
  List doctors = <dynamic>[
    <String, Object>{
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
      'available_times': <Map<String, List<Object>>>[
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
            <String, String>{'time': '2:00 - 3:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['الاحد'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
      ],
      'qualifications': <Map<String, String>>[
        <String, String>{
          'icon': iconUniversity,
          'title': 'university'.tr,
          'university': 'al_azhar_al_sharif'.tr,
        },
        <String, String>{
          'icon': iconAcademicDegree,
          'title': 'academic_degree'.tr,
          'university': 'bachelor_of_medicine_and_surgery'.tr,
        },
      ],
      'practicalExperienceIn': <String>[
        'list_experience_in_1'.tr,
        'list_experience_in_2'.tr,
        'list_experience_in_3'.tr,
        'list_experience_in_4'.tr,
      ],
      'clinicalExperience': <String>['clinical_experience_deception'.tr],
    },
    <String, Object>{
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
      'available_times': <Map<String, List<Object>>>[
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
            <String, String>{'time': '2:00 - 3:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['الاحد'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين', 'الخميس', 'الاربعاء', 'الجمعة'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
      ],
      'qualifications': <Map<String, String>>[
        <String, String>{
          'icon': iconUniversity,
          'title': 'university'.tr,
          'university': 'al_azhar_al_sharif'.tr,
        },
        <String, String>{
          'icon': iconAcademicDegree,
          'title': 'academic_degree'.tr,
          'university': 'bachelor_of_medicine_and_surgery'.tr,
        },
      ],
      'practicalExperienceIn': <String>[
        'list_experience_in_1'.tr,
        'list_experience_in_2'.tr,
        'list_experience_in_3'.tr,
        'list_experience_in_4'.tr,
      ],
      'clinicalExperience': <String>['clinical_experience_deception'.tr],
    },
    <String, Object>{
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
      'available_times': <Map<String, List<Object>>>[
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
            <String, String>{'time': '2:00 - 3:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['الاحد'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 6:00 مساءً'},
          ],
        },
        <String, List<Object>>{
          'days': <String>['السبت', 'الإثنين'],
          'times': <Map<String, String>>[
            <String, String>{'time': '1:00 - 4:00 مساءً'},
          ],
        },
      ],
      'qualifications': <Map<String, String>>[
        <String, String>{
          'icon': iconUniversity,
          'title': 'university'.tr,
          'university': 'al_azhar_al_sharif'.tr,
        },
        <String, String>{
          'icon': iconAcademicDegree,
          'title': 'academic_degree'.tr,
          'university': 'bachelor_of_medicine_and_surgery'.tr,
        },
        <String, String>{
          'icon': iconAcademicDegree,
          'title': 'academic_degree'.tr,
          'university': 'bachelor_of_medicine_and_surgery'.tr,
        },
        <String, String>{
          'icon': iconAcademicDegree,
          'title': 'academic_degree'.tr,
          'university': 'bachelor_of_medicine_and_surgery'.tr,
        },
      ],
      'practicalExperienceIn': <String>[
        'list_experience_in_1'.tr,
        'list_experience_in_2'.tr,
        'list_experience_in_3'.tr,
        'list_experience_in_4'.tr,
      ],
      'clinicalExperience': <String>[
        'clinical_experience_deception'.tr,
        'clinical_experience_deception'.tr,
      ],
    },
  ];

  double calculateWidth(String text) {
    return text.length * 3 + 1;
  }
}
