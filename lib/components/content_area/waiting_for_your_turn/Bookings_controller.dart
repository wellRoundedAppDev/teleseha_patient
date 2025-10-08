import 'dart:async';

import '../../../general_exports.dart';

class BookingsController extends GetxController {
  int? passedIndex = 0;
  int? get selectedRecentBookingsId => passedIndex;
  // ignore: always_specify_types
  Map? selectedLastRecent;
  int currentStep = 0;
  final int totalSteps = 5;
  int remainingMinutes = 1;
  bool isLoading = false;
  String? accessToken;

  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      remainingMinutes > 0 ? remainingMinutes-- : timer.cancel();
      // ignore: unnecessary_statements
      remainingMinutes == 10 || remainingMinutes == 0 ? currentStep = 2 : null;
      update();
    });

    _comming();
    // _sessionWaitingData();
  }

  // ignore: always_specify_types
  List lastRecent = <dynamic>[];
  Future<void> _comming() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: comming,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        lastRecent = response ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        // specialtiesWithSub = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  // ignore: always_specify_types
  // List lastWatingData = <dynamic>[];
  // Future<void> _sessionWaitingData() async {
  //   isLoading = true;
  //   update();
  //   accessToken = await localStorage.readFromStorage(storageAccessToken);
  //   await ApiRequest(
  //     path: '$session/$selectedRecentBookingsId',
  //     className: '',
  //     formatResponse: true,
  //     header: <String, dynamic>{
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) async {
  //       lastWatingData = response ?? <dynamic>[];
  //       update();
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       // specialtiesWithSub = 'not_found_medical_profile_section'.tr;
  //       update();
  //       return null;
  //     },
  //   );
  //   isLoading = false;
  //   update();
  // }

  Future<void> chatPostRequest() async {
    await ApiRequest(
      path: ratingReview,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        rating: 3,
        review: 'string',
        callTimeRating: 3,
        isFirstAdvantage: true,
        isSecondAdvantage: true,
        isThirdAdvantage: true,
        checkupId: 123,
        doctorId: 2,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        // Get.toNamed(details);
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        isLoading = false;
        update();
        return null;
      },
    );
  }

  // ignore: always_specify_types
  // List lastRecent = [
  //   <String, Object>{
  //     'id': 1,
  //     'image': imageDoctor,
  //     'name': 'name_doctor1',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  //   <String, Object>{
  //     'id': 2,
  //     'image': imageDoctorDetails,
  //     'name': 'name_doctor2',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  //   <String, Object>{
  //     'id': 3,
  //     'image': imageDoctor,
  //     'name': 'name_doctor1',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  //   <String, Object>{
  //     'id': 4,
  //     'image': imageDoctor,
  //     'name': 'name_doctor1',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  //   <String, Object>{
  //     'id': 5,
  //     'image': imageDoctor,
  //     'name': 'name_doctor1',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  //   <String, Object>{
  //     'id': 6,
  //     'image': imageDoctor,
  //     'name': 'name_doctor1',
  //     'specialization': 'general_internal_affairs',
  //     'range': '4.9',
  //     'reveal': 'detection_times'.tr,
  //     'date': 'accosts'.tr,
  //     'time': '2:00',
  //   },
  // ];

  // void selectedLastRecentFunction() {
  //   selectedLastRecent = lastRecent.firstWhere(
  //     // ignore: non_constant_identifier_names, always_specify_types
  //     (LastRecent) => LastRecent['id'] == selectedRecentBookingsId,
  //     orElse: () => <dynamic, dynamic>{},
  //   );
  // }
}
