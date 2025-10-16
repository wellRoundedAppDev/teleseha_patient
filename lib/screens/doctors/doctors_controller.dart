import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../general_exports.dart' hide FormData;

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
  final ChangeParamContentAndNextPage change = Get.find();

  bool isLoading = false;
  bool showDoctors = false;
  List<int> sessionIds = <int>[];

  final double widthSelected = DEVICE_WIDTH <= 380 ? 0.38 : 0.4;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 15;
  RxList<Map<String, dynamic>> filteredSessions = <Map<String, dynamic>>[].obs;

  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;
  // ignore: always_specify_types
  Map? selectedDoctor;
  RxInt selectedRatingIndex = (0).obs;
  bool isLoadingDoctor = false;
  String? accessToken;
  LocalStorage localStorage = LocalStorage();
  String? showText;

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
  int? selectedIndex;
  int? selectedSessionId;

  void updateSelectedSession() {
    if (selectedIndex != null && doctorsProfileSessions.isNotEmpty) {
      selectedSessionId = doctorsProfileSessions[selectedIndex!]['sessionId'];
    }
  }

  RxList<WeekDay> weekDays = <WeekDay>[].obs;
  String currentDay = '';
  int? selectedDayIndex;
  String savedDateWithDay = '';

  String? selectedTime;
  int? loukMyPatientId;
  DateTime selectedDate = DateTime.now();

  TextEditingController yourCommentOnTheSession = TextEditingController();

  Future<void> _loadPatientId() async {
    final String? userJson = await localStorage.readFromStorage(
      storageUserData,
    );
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final int? patientId = userMap['patients']?[0]?['patientId'];
      if (patientId != null) {
        loukMyPatientId = patientId;
      }
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.toLocal(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      selectedDate = picked;

      selectedMonthName = DateFormat('MMMM yyyy', 'ar').format(picked);
      generateWeekDays();

      final DateTime startOfWeek = picked.subtract(
        Duration(days: picked.weekday % 7),
      );

      savedDateWithDay = DateFormat('yyyy-MM-dd').format(picked);

      await saveDateWithDay();

      selectedDayIndex = picked.difference(startOfWeek).inDays;
      update();
    } else {}
    update();
  }

  Future<void> saveDateWithDay() async {
    final DateTime currentDate = selectedDate;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    savedDateWithDay = formattedDate;
    consoleLog('>>> savedDateWithDay = $savedDateWithDay');

    filteredSessions.value = doctorsProfileSessions
        .where(
          (Map<String, dynamic> session) => session['date'] == savedDateWithDay,
        )
        .toList();
    update();
  }

  Future<void> sendSelectedSession() async {
    if (isSelected == 0) {
      Get.snackbar(
        'worryning'.tr,
        'enter_worryning'.tr,
        snackPosition: SnackPosition.BOTTOM,
        // ignore: deprecated_member_use
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    final FormData formData = FormData.fromMap(<String, dynamic>{
      mySessionId: selectedSessionId,
      myPatientId: loukMyPatientId,
    });

    await ApiRequest(
      path: appotntmentControllersPath,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: formData,
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        change.goToComponentHeader.value = 'successSendToDoctor';
        change.update();
        consoleLog(change.goToComponentHeader.value);
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final FingerPrintController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    _loadPatientId();
    generateWeekDays();
    selectedDayIndex = selectedDate.weekday == 7 ? 0 : selectedDate.weekday;
    final ChangeParamContentAndNextPage change = Get.find();
    if (change.knowNextPage.value ==
        'comping from subSpiecilaties going to profile doctor') {
    } else {
      doctorsRequest();
    }
    update();
  }

  void generateWeekDays() {
    final DateTime current = selectedDate.toLocal();

    final int daysToSubtract = (current.weekday == 7) ? 0 : current.weekday;

    final DateTime startOfWeek = current.subtract(
      Duration(days: daysToSubtract),
    );

    weekDays.clear();
    for (int i = 0; i < 7; i++) {
      final DateTime dayDate = startOfWeek.add(Duration(days: i));
      final String dayName = DateFormat('EEEE', 'ar').format(dayDate);
      final bool isAvailable = dayDate.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      final int dayOfMonth = dayDate.day;
      weekDays.add(
        WeekDay(dayName: dayName, isAvailable: isAvailable, date: dayOfMonth),
      );
    }

    update();
  }

  void selectDay(int index) {
    selectedDayIndex = index;

    final DateTime current = selectedDate.toLocal();
    final int daysToSubtract = (current.weekday == 7) ? 0 : current.weekday;
    final DateTime startOfWeek = current.subtract(
      Duration(days: daysToSubtract),
    );

    selectedDate = startOfWeek.add(Duration(days: index));
    selectedMonthName = DateFormat('MMMM yyyy', 'ar').format(selectedDate);

    saveDateWithDay();
    update();
  }

  String getTimePeriod(String startTime) {
    try {
      final int hour = int.parse(startTime.split(':')[0]);

      if (hour >= 6 && hour < 12) {
        return 'صباحًا';
      } else if (hour >= 12 && hour < 17) {
        return 'ظهرًا';
      } else if (hour >= 17 && hour < 21) {
        return 'مساءً';
      } else {
        return 'ليلًا';
      }
    } catch (e) {
      return 'غير معروف';
    }
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
    isLoadingDoctor = true;
    update();

    accessToken = await localStorage.readFromStorage(storageAccessToken);

    // &$availableDate=${selectedAppointmentKey ?? ''}
    final String query =
        '$doctor?$keyName=${filterDoctors.text.trim()}&$specialityId=${selectedSpecialityId ?? ''}&$scientificDegree=${selectedacademicDegree ?? ''}&$maxPrice=${currentSliderValue ?? ''}';

    await ApiRequest(
      path: query,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        doctors = response ?? <dynamic>[];
        for (int i = 0; i < doctors.length; i++) {
          doctors[i]['availableAdvantages'] = _getAdvantagesFromDoctorData(
            doctors[i],
          );
          if (doctors[i]['specialty'] == 'ممارس عام') {
            showText = 'general_specialty_doctors'.tr;
            update();
          } else {
            showText = 'doctors'.tr;
            update();
          }
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
    isLoadingDoctor = false;
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
    isLoadingDoctor = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$doctorProfile/$selectedDoctorId',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
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
    isLoadingDoctor = false;
    update();
  }

  List<Map<String, dynamic>> doctorsProfileSessions = <Map<String, dynamic>>[];
  Future<void> doctorsProfileSessionsRequest() async {
    isLoadingDoctor = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$doctor/$selectedDoctorId/$doctorProfileSessions',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        consoleLog('>>> API sessions response: $response');
        // ignore: always_specify_types
        for (var session in response) {
          sessionIds.add(session['sessionId']);
        }
        // sessionId = response['sessionId'] ?? <dynamic>[];
        doctorsProfileSessions = List<Map<String, dynamic>>.from(
          response ?? <dynamic>[],
        );
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        update();
        return null;
      },
    );
    isLoadingDoctor = false;
    update();
  }

  double calculateWidth(String text) {
    return text.length * 3 + 1;
  }

  final List<String> tabs = <String>['practical_experiments'.tr, 'ratings'.tr];

  final List ratings = <dynamic>[
    <String, String>{'titleRatings': 'good_listen'.tr, 'icon': iconGoodListen},
    <String, String>{'titleRatings': 'friendly'.tr, 'icon': iconCalm},
    <String, String>{'titleRatings': 'explains_clearly'.tr, 'icon': iconHappy},
  ];
}
