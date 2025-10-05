import 'dart:convert';

import '../../general_exports.dart';

class HomePageContentController extends GetxController {
  // here get user name about response refresh-login request
  String testNameUserData = 'name_user'.tr;

  // here check response if have last reservations
  int nextReservation = 3;
  int selectedSpecialtyIndex = 0;
  int selectedIndex = 2;
  int selectedacademicDegree = 1;
  int selectedAppointmentsAvailable = 1;
  final ScrollController scrollController = ScrollController();
  RxBool isDrawerOpen = false.obs;
  RxDouble currentSliderValue = 100.0.obs;
  bool isLoading = false;
  String? accessToken;

  LocalStorage localStorage = LocalStorage();

  final ChangeParamContentAndNextPage change = Get.find();

  @override
  void onInit() {
    super.onInit();
    _specialityRequest();
    _loadUserName();
    // _checkCommingRequest();
    // _subSpecialityRequest();
  }

  Future<void> _loadUserName() async {
    final String? userJson = await localStorage.readFromStorage(
      storageUserData,
    );

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final String? name = userMap['patients']?[0]?['name'];
      if (name != null && name.isNotEmpty) {
        testNameUserData = name;
        update();
      }
    }
  }

  // ignore: always_specify_types
  List specialties = <dynamic>[];
  Future<void> _specialityRequest() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: speciality,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
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
  // List subSpecialties = <dynamic>[];
  // Future<void> _subSpecialityRequest() async {
  //   isLoading = true;
  //   update();
  //   accessToken = await localStorage.readFromStorage(storageAccessToken);
  //   await ApiRequest(
  //     path: '$subSpeciality/3',
  //     className: '',
  //     formatResponse: true,
  //     header: <String, dynamic>{
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) async {
  //       subSpecialties = response ?? <dynamic>[];
  //       update();
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       // specialties = 'not_found_medical_profile_section'.tr;
  //       update();
  //       return null;
  //     },
  //   );
  //   isLoading = false;
  //   update();
  // }

  // ignore: always_specify_types
  // List checkComming = <dynamic>[];
  // Future<void> _checkCommingRequest() async {
  //   isLoading = true;
  //   update();
  //   accessToken = await localStorage.readFromStorage(storageAccessToken);
  //   await ApiRequest(
  //     path: checkCommingPath,
  //     className: '',
  //     formatResponse: true,
  //     header: <String, dynamic>{
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) async {
  //       checkComming = response ?? <dynamic>[];
  //       update();
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       update();
  //       return null;
  //     },
  //   );
  //   isLoading = false;
  //   update();
  // }

  void openContentDoctorsAboutSelected(int index) {
    final ChangeParamContentAndNextPage changeParam = Get.find();
    if (index == 0) {
      final BottomNavController homeBottomController = Get.find();
      homeBottomController.selectedIndexBottomNav.value = 3;
      changeParam.goToComponentHeader.value = 'Doctors';
      selectedSpecialtyIndex = index;
      change.knowNextPage.value = '';
      homeBottomController.update();
      update();
    } else {
      changeParam.goToComponentHeader.value = 'Subspecialty';
      selectedSpecialtyIndex = index;
      update();
    }
  }

  final List<Map<String, dynamic>> academicDegree = <Map<String, dynamic>>[
    <String, dynamic>{'title': 'general_practitioner'.tr},
    <String, dynamic>{'title': 'specialist'.tr},
    <String, dynamic>{'title': 'consultative'.tr},
    <String, dynamic>{'title': 'teacher'.tr},
    <String, dynamic>{'title': 'mr'.tr},
  ];

  final List<Map<String, dynamic>> appointmentsAvailable =
      <Map<String, dynamic>>[
        <String, dynamic>{'title': 'today'.tr},
        <String, dynamic>{'title': 'tomorrow'.tr},
        <String, dynamic>{'title': 'this_week'.tr},
      ];
}
