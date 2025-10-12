import 'dart:convert';

import '../../general_exports.dart';

class HomePageContentController extends GetxController {
  // here get user name about response refresh-login request
  String testNameUserData = 'name_user'.tr;

  // here check response if have last reservations
  int selectedSpecialtyIndex = 0;
  int selectedIndex = 2;
  String selectedacademicDegree = 'Consultant';
  int? selectedAppointmentsAvailable = 1;
  final ScrollController scrollController = ScrollController();
  RxBool isDrawerOpen = false.obs;
  RxDouble currentSliderValue = 100.0.obs;
  bool isLoading = false;
  String? accessToken;
  int? loukMyPatientId;
  bool? isShowPage = true;
  String? nextReservationMinute;

  LocalStorage localStorage = LocalStorage();

  final ChangeParamContentAndNextPage change = Get.find();

  @override
  void onInit() {
    super.onInit();
    specialityRequest();
    _loadUserName();
    _checkCommingRequest();
    _initData();
  }

  Future<void> _initData() async {
    await _loadUserName();
    if (loukMyPatientId != null) {
      await _checkCommingRequest();
    }
  }

  Future<void> _loadUserName() async {
    final String? userJson = await localStorage.readFromStorage(
      storageUserData,
    );

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final String? name = userMap['patients']?[0]?['name'];
      final int? patientId = userMap['patients']?[0]?['patientId'];
      if (name != null && name.isNotEmpty) {
        testNameUserData = name;
        loukMyPatientId = patientId;
        update();
      }
    }
  }

  // ignore: always_specify_types
  List specialties = <dynamic>[];
  Future<void> specialityRequest() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: speciality,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        specialties = response ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        // specialties = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  // ignore: always_specify_types
  List subSpecialties = <dynamic>[];
  // ignore: always_specify_types
  Future<void> _subSpecialityRequest(id) async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    try {
      await ApiRequest(
        path: '$subSpeciality/$id',
        className: '',
        formatResponse: true,
        header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
      ).request(
        onSuccess: (dynamic data, dynamic response) async {
          if (response is List) {
            subSpecialties = response;
            isShowPage = true;
          } else {
            subSpecialties = <dynamic>[];
            isShowPage = false;
          }
          update();
        },
        onError: (error) {
          subSpecialties = <dynamic>[];
          isShowPage = false;
          update();
          return null;
        },
      );
    } catch (e) {
      subSpecialties = <dynamic>[];
      isShowPage = false;
      update();
    }

    isLoading = false;
    update();
  }

  // ignore: always_specify_types
  Map<String, dynamic> checkComming = {};
  Future<void> _checkCommingRequest() async {
    if (loukMyPatientId == null) {
      return;
    }

    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$checkCommingPath/$loukMyPatientId',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        if (response != null && response is Map<String, dynamic>) {
          checkComming = response;
          final String? nextDateTimeStr = response['next_date_time'];
          if (nextDateTimeStr != null) {
            final DateTime dateTime = DateTime.parse(nextDateTimeStr);
            nextReservationMinute = dateTime.minute.toString().padLeft(2, '0');
          }
          update();
        }
      },
      // ignore: always_specify_types
      onError: (error) {
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  Future<void> openContentDoctorsAboutSelected(int index) async {
    final ChangeParamContentAndNextPage changeParam = Get.find();
    final BottomNavController homeBottomController = Get.find();
    await _subSpecialityRequest(index);

    if (isShowPage == true) {
      changeParam.goToComponentHeader.value = 'Subspecialty';
      change.knowNextPage.value = '';
      // showText = 'doctors'.tr;
      change.update();
      changeParam.update();
      update();
    } else {
      change.knowNextPage.value =
          'comping from subSpiecilaties going to profile doctor';
      Get.put(DoctorsController(), permanent: true);
      final DoctorsController doctor = Get.find();
      doctor.doctorsRequest(index);
      // showText = 'general_specialty_doctors'.tr;
      homeBottomController.selectedIndexBottomNav.value = 3;
      changeParam.goToComponentHeader.value = 'Doctors';
      selectedSpecialtyIndex = index;
      homeBottomController.update();
      change.update();
      update();
    }
  }

  final List<Map<String, dynamic>> academicDegree = <Map<String, dynamic>>[
    <String, dynamic>{'key': 'Bachelora', 'title': 'bachelora'.tr},
    <String, dynamic>{'key': 'Master', 'title': 'master'.tr},
    <String, dynamic>{'key': 'Doctorate', 'title': 'doctorate'.tr},
    <String, dynamic>{'key': 'Consultant', 'title': 'consultant'.tr},
    <String, dynamic>{
      'key': 'AssociateProfessor',
      'title': 'associateProfessor'.tr,
    },
    <String, dynamic>{'key': 'Professor', 'title': 'professor'.tr},
  ];

  final List<Map<String, dynamic>> appointmentsAvailable =
      <Map<String, dynamic>>[
        <String, dynamic>{'key': 'today', 'title': 'today'.tr},
        <String, dynamic>{'key': 'tomorrow', 'title': 'tomorrow'.tr},
        <String, dynamic>{'key': 'thisWeek', 'title': 'this_week'.tr},
      ];
}
