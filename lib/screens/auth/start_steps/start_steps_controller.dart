import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart' hide FormData;

class StartStepsController extends GetxController {
  int currentStep = 1;
  int numberOfStep = 3;
  bool? checkSignInOrSignUp = false;
  final bool isSignIn = false;
  List<int> tempSavedPattern = <int>[];
  List<int> inputPattern = <int>[];
  bool isLoading = false;
  String dataPassword = '';
  bool selectedMaleCode = true;
  String? accessToken;
  String? apiDate;
  int? patientId;
  String? name;
  String? barthDay;
  bool? myIsMale;

  final AuthStorageController authStorage = Get.find();

  TextEditingController otpController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  LocalStorage localStorage = LocalStorage();

  LoginController login = Get.find();

  bool showPhoneNumberError = false;
  bool showOtpError = false;
  bool showNameError = false;
  bool showdateControllerError = false;

  int secondsRemaining = 70;
  Timer? timer;

  List<int> patterns = <int>[];
  PatternState state = PatternState.normal;

  // ignore: always_specify_types
  List typeGenerate = <dynamic>[
    <String, Object>{'gender': 'انثى'.tr, 'icon': iconFemale, 'code': false},
    <String, Object>{'gender': 'ذكر'.tr, 'icon': iconMale, 'code': true},
  ];

  void minusSelectedSteps() {
    currentStep--;
    update();
  }

  // ignore: always_specify_types
  void changeTypeGenerate(typeCode) {
    selectedMaleCode = typeCode;
    update();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate = picked;

      final String formattedDate =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';

      final String formattedApiDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

      dateController.text = formattedDate;
      apiDate = formattedApiDate;

      update();
    } else {
      consoleLog('❌ Date picker dismissed');
    }
  }

  bool checkOtp() {
    if (!isOtpValid()) {
      markOtpInvalid();
      return false;
    }
    clearOtpError();
    return true;
  }

  Future<void> checkOtpToNextPage() async {
    if (_isOtpExpired()) {
      return;
    }

    if (!checkOtp()) {
      return;
    }

    isLoading = true;
    update();

    final LoginController controller = Get.find<LoginController>();

    if (controller.page == 'signIn') {
      _handleSignIn(controller);
    } else if (controller.page == 'signUp') {
      await _handleSignUp(controller);
    }

    isLoading = false;
    update();
  }

  bool _isOtpExpired() {
    if (secondsRemaining <= 0) {
      Get.snackbar(
        'error'.tr,
        'otp_time_expired'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return true;
    }
    return false;
  }

  void _handleSignIn(LoginController controller) {
    controller.updatePage('update');
    otpController.clear();
    Get.to(() => const PatternLock());
    controller.resetPattern();
  }

  Future<void> _handleSignUp(LoginController controller) async {
    await ApiRequest(
      path: otpConfirm,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, dynamic>{
        mobile: login.passNumberPhone.trim(),
        otp: otpController.text,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        isLoading = false;
        final String? data = response['data']?.toString();
        final String? nextStep = response['nextStepEnum']?.toString();
        if (nextStep == 'CreatePassword') {
          controller.updatePage('signUp');
          otpController.clear();
          Get.toNamed(routeSteps);
          dataPassword = data ?? '';
        }
        showOtpError = false;
        ++currentStep;
        clearOtpError();
      },
      onError: (error) {
        otpController.clear();
        markOtpInvalid();
        showOtpError = true;
        return null;
      },
    );
  }

  void startPattern() {
    if (state == PatternState.error || state == PatternState.success) {
      resetPattern();
    } else {
      state = PatternState.active;
      update();
    }
  }

  void updatePattern(List<int> pattern) {
    inputPattern = pattern;
    update();
  }

  void resetPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();
  }

  // create pattern
  bool canGoToStepTwo(List<int> pattern) {
    if (pattern.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'error_pattern'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (tempSavedPattern.isEmpty) {
      // ignore: always_specify_types
      tempSavedPattern = List.from(pattern);
      state = PatternState.success;
      update();
      return true;
    } else {
      // ignore: always_specify_types
      inputPattern = List.from(pattern);
      if (listEquals(inputPattern, tempSavedPattern)) {
        state = PatternState.success;
        update();
        return true;
      } else {
        state = PatternState.error;
        update();
        Get.snackbar(
          'error'.tr,
          'error_pattern'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    }
  }

  Future<void> onNextButtonPress() async {
    if (currentStep == 2) {
      if (!canGoToStepTwo(inputPattern)) {
        return;
      }

      isLoading = true;
      update();

      await ApiRequest(
        path: createPassword,
        className: '',
        formatResponse: true,
        method: ApiMethods.post,
        body: <String, String>{
          mobile: login.passNumberPhone.trim(),
          password: inputPattern.join(),
          createPasswordToken: dataPassword,
        },
      ).request(
        // ignore: always_specify_types
        onSuccess: (data, response) async {
          isLoading = false;
          final String? nextStep = response['nextStepEnum']?.toString();
          if (nextStep == 'CreateProfile') {
            await authStorage.saveAuthData(response['data']);
            currentStep++;
          }
          update();
        },
        onError: (_) {
          isLoading = false;
          update();
          return null;
        },
      );

      resetPattern();
      update();
    } else if (currentStep == 3) {
      isLoading = true;
      update();
      accessToken = await localStorage.readFromStorage(storageAccessToken);

      final FormData formData = FormData.fromMap(<String, dynamic>{
        keyName: textFieldName.text.trim(),
        isMale: selectedMaleCode,
        date: apiDate,
      });

      await ApiRequest(
        path: patient,
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
          patientId = response['patientId'];
          name = response['name'];
          barthDay = response['birthDate'];
          final String? genderStr = response['gender']
              ?.toString()
              .toLowerCase();
          genderStr == 'male'
              ? myIsMale = true
              : genderStr == 'female'
              ? myIsMale = false
              : myIsMale = null;
          final Map<String, dynamic> userMap = <String, dynamic>{
            'patients': <Map<String, dynamic>>[
              <String, dynamic>{myPatientId: response['patientId']},
            ],
          };
          await localStorage.saveToStorage(
            key: storageUserData,
            value: jsonEncode(userMap),
          );
          await localStorage.readFromStorage(storageUserData);
          // ignore: always_specify_types
          await Future.delayed(const Duration(milliseconds: 300));
          Get.toNamed(routeCreateAccountSuccess);
          update();
        },
        // ignore: always_specify_types
        onError: (error) {
          final int? statusCode = error.response?.statusCode;
          isLoading = false;
          update();
          if (statusCode == 401) {
            final LoginController appController = Get.find();
            appController.futureRefreshLogin();
          } else {
            if (textFieldName.text.isEmpty) {
              showNameError = true;
              update();
            } else {
              showNameError = false;
              update();
            }
            if (dateController.text.isEmpty) {
              showdateControllerError = true;
              update();
            } else {
              showdateControllerError = false;
              update();
            }
          }
          return null;
        },
      );
    }
  }

  void restartTimer() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final int minutes = secondsRemaining ~/ 60;
    final int secs = secondsRemaining % 60;
    return '[$minutes:${secs.toString().padLeft(2, '0')}]';
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    otpController.dispose();
  }

  void markOtpInvalid() {
    showOtpError = true;
    update();
  }

  void clearOtpError() {
    showOtpError = false;
    update();
  }

  bool isOtpValid() {
    return otpController.text.length == 6;
  }
}
