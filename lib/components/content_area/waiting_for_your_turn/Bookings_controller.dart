import 'dart:async';
import 'dart:convert' show jsonDecode;

import 'package:intl/intl.dart';

import '../../../general_exports.dart' hide FormData;

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
  int? loukMyPatientId;

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

    _loadUserName();
    _comming();
    // _sessionWaitingData();
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
        loukMyPatientId = patientId;
      }
    }
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      final String formatted = DateFormat('dd MMMM', 'ar').format(date);
      return formatted;
    } catch (e) {
      return 'تاريخ غير صالح';
    }
  }

  // ignore: always_specify_types
  List lastRecent = <dynamic>[];
  Future<void> _comming() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$comming/$loukMyPatientId',
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
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

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
      body: <String, Object>{
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

  // void selectedLastRecentFunction() {
  //   selectedLastRecent = lastRecent.firstWhere(
  //     // ignore: non_constant_identifier_names, always_specify_types
  //     (LastRecent) => LastRecent['id'] == selectedRecentBookingsId,
  //     orElse: () => <dynamic, dynamic>{},
  //   );
  // }
}
