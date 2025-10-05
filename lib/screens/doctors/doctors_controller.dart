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

  final double widthSelected = DEVICE_WIDTH <= 380 ? 0.38 : 0.4;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;

  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;
  // ignore: always_specify_types
  Map? selectedDoctor;
  RxInt selectedRatingIndex = (0).obs;
  bool isLoading = false;
  String? accessToken;
  LocalStorage localStorage = LocalStorage();

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
    doctorsRequest();
    // _doctorsProfileRequest();
    // _doctorsProfileSesscions();
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

  // ignore: always_specify_types
  List doctors = <dynamic>[];
  // ignore: always_specify_types
  Future<void> doctorsRequest([
    int? selectedSpecialityId,
    String? selectedacademicDegree,
    double? currentSliderValue,
    String? selectedAppointmentKey,
  ]) async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    // &$availableDate=${selectedAppointmentKey ?? ''}
    final String query =
        '$doctor?$keyName=${filterDoctors.text.trim()}&$specialityId=${selectedSpecialityId ?? ''}&$scientificDegree=${selectedacademicDegree ?? ''}&$maxPrice=${currentSliderValue ?? ''}';

    await ApiRequest(
      path: query,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        doctors = response ?? <dynamic>[];
        for (int i = 0; i < doctors.length; i++) {
          doctors[i]['availableAdvantages'] = _getAdvantagesFromDoctorData(
            doctors[i],
          );
        }
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        // doctors = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  List<Map<String, String>> _getAdvantagesFromDoctorData(
    Map<String, dynamic> doctorData,
  ) {
    final List<Map<String, String>> advantages = <Map<String, String>>[];

    if ((doctorData['firstAdvantageValue'] ?? 0) > 0.5) {
      advantages.add(<String, String>{
        'title': 'explains_clearly'.tr,
        'icon': iconGoodListen,
      });
    }

    if ((doctorData['firstAdvantageValue'] ?? 0) > 0.5) {
      advantages.add(<String, String>{'title': 'wd'.tr, 'icon': iconCalm});
    }

    if ((doctorData['thirdAdvantageValue'] ?? 0) > 0.5) {
      advantages.add(<String, String>{
        'title': 'good_listen'.tr,
        'icon': iconHappy,
      });
    }

    return advantages;
  }

  // ignore: always_specify_types
  Map<String, dynamic> doctorsProfile = {};
  Future<void> doctorsProfileRequest() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$doctorProfile/$selectedDoctorId',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        doctorsProfile = response ?? <String, dynamic>{};
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        // doctors = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  double calculateWidth(String text) {
    return text.length * 3 + 1;
  }

  // ignore: always_specify_types
  List commints = <dynamic>[
    <String, Object>{
      'icon': iconUser,
      'name': 'name_field'.tr,
      'title': 'good_rating'.tr,
      'rating': 5.0,
    },
    <String, Object>{
      'icon': iconUser,
      'name': 'name_field'.tr,
      'title': 'good_rating'.tr,
      'rating': 3.0,
    },
    <String, Object>{
      'icon': iconUser,
      'name': 'name_field'.tr,
      'title': 'good_rating'.tr,
      'rating': 2.0,
    },
    <String, Object>{
      'icon': iconUser,
      'name': 'name_field'.tr,
      'title': 'good_rating'.tr,
      'rating': 1.0,
    },
  ];

  final List<String> tabs = <String>['practical_experiments'.tr, 'ratings'.tr];

  final List ratings = <dynamic>[
    <String, String>{'titleRatings': 'good_listen'.tr, 'icon': iconGoodListen},
    <String, String>{'titleRatings': 'friendly'.tr, 'icon': iconCalm},
    <String, String>{'titleRatings': 'explains_clearly'.tr, 'icon': iconHappy},
  ];
}
