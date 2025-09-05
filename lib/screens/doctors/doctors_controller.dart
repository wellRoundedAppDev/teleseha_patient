// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../general_exports.dart';

class WeekDay {
  WeekDay({
    required this.dayName,
    required this.isAvailable,
    required this.date,
  });
  String dayName;
  bool isAvailable;
  final int date;
}

class DoctorsController extends GetxController {
  TextEditingController filterDoctors = TextEditingController();

  bool showDoctors = false;

  final double widthSelected = DEVICE_WIDTH <= 380 ? 0.45 : 0.48;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;

  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;
  // ignore: always_specify_types
  Map? selectedDoctor;
  RxInt selectedRatingIndex = (0).obs;

  RxList<Map<String, dynamic>> availableTimes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> qualifications = <Map<String, dynamic>>[].obs;
  RxList<String> heHasExperienceIn = <String>[].obs;
  RxList<String> clinicalExperience = <String>[].obs;

  String selectedMonthName = DateFormat(
    'MMMM yyyy',
    'ar',
  ).format(DateTime.now());

  bool selectedGeneralOrSpecializedMajor = true;

  int isSelected = 0;

  RxList<WeekDay> weekDays = <WeekDay>[].obs;
  String currentDay = '';
  int? selectedDayIndex;
  String savedDateWithDay = '';

  String? selectedTime;

  DateTime selectedDate = DateTime.now();

  TextEditingController yourCommentOnTheSession = TextEditingController();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      selectedDate = picked;
      selectedMonthName = DateFormat('MMMM yyyy', 'ar').format(picked);
      generateWeekDays();
      update();
    } else {
      consoleLog('❌ Date picker dismissed');
    }
    update();
  }

  void saveDateWithDay() {
    final DateTime currentDate = selectedDate;
    final String dayName = DateFormat('EEEE', 'ar').format(currentDate);
    final String formattedDate = DateFormat(
      'dd MMMM yyyy',
      'ar',
    ).format(currentDate);

    savedDateWithDay = '$dayName, $formattedDate';
    update();
    consoleLog('تم حفظ التاريخ مع يوم الأسبوع: $savedDateWithDay');
  }

  @override
  void onInit() {
    super.onInit();
    generateWeekDays();
    final DateTime currentDate = DateTime.now();
    selectedDayIndex = currentDate.weekday - 3;
    update();
  }

  void generateWeekDays() {
    final List<String> days = <String>[
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];

    final DateTime currentDate = selectedDate;
    final int currentDayIndex = currentDate.weekday - 3;

    // currentDay = days[currentDayIndex];

    weekDays.clear();
    for (int i = 0; i < 7; i++) {
      final DateTime dayDate = currentDate.add(Duration(days: i));
      final String dayName = DateFormat('EEEE', 'ar').format(dayDate);
      final bool isAvailable = dayDate.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      final int dayOfMonth = dayDate.day;
      weekDays.add(
        WeekDay(dayName: dayName, isAvailable: isAvailable, date: dayOfMonth),
      );
    }
  }

  void selectDay(int index) {
    selectedDayIndex = index;

    final DateTime currentDate = selectedDate;

    final DateTime newSelectedDate = currentDate
        .subtract(Duration(days: currentDate.weekday - 3))
        .add(Duration(days: index));

    selectedDate = newSelectedDate;
    selectedMonthName = DateFormat('MMMM yyyy', 'ar').format(selectedDate);
    update();
  }

  void selectedDoctorFunction() {
    selectedDoctor = doctors.firstWhere(
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

  final List<String> tabs = <String>['practical_experiments'.tr, 'ratings'.tr];

  final List ratings = <dynamic>[
    <String, String>{'titleRatings': 'good_listen'.tr, 'icon': iconGoodListen},
    <String, String>{'titleRatings': 'friendly'.tr, 'icon': iconCalm},
    <String, String>{'titleRatings': 'explains_clearly'.tr, 'icon': iconHappy},
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
            <String, String>{'time': '3:00 - 7:00 مساءً'},
            <String, String>{'time': '5:00 - 4:00 مساءً'},
            <String, String>{'time': '6:00 - 1:00 مساءً'},
            <String, String>{'time': '2:00 - 4:00 مساءً'},
            <String, String>{'time': '1:00 - 8:00 مساءً'},
            <String, String>{'time': '1:00 - 3:00 مساءً'},
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
