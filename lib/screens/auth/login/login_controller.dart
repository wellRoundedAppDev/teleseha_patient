import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  List<int> tempSavedPattern = <int>[];

  String? myNextStep;
  dynamic refreshToken;
  final AuthStorageController authStorage = Get.find();
  // final StartStepsController stepController = Get.find();

  String page = 'signIn';
  String phoneErrorMessage = '';
  String passNumberPhone = '';

  bool showPhoneNumberError = false;
  double linePercentage = 0.0;

  List<int> inputPattern = <int>[];
  PatternState state = PatternState.normal;
  bool showForgetPatter = false;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;
  String? showPage;
  String? showPathMobileRegistered;

  @override
  Future<void> onInit() async {
    super.onInit();
    await futureRefreshLogin();
    // await loadPatientsFromStorage();
  }

  Future<void> futureRefreshLogin() async {
    refreshToken = await localStorage.getFromStorage(key: storageRefreshToken);
    await ApiRequest(
      path: refreshLogin,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, String?>{myRefreshToken: refreshToken},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        final String? nextStep = response['nextStepEnum']?.toString();

        await authStorage.saveAuthData(response['data']);

        myNextStep = nextStep;
        update();

        switch (nextStep) {
          case 'CreateProfile':
            // stepController.currentStep = 3;
            // stepController.update();
            Get.toNamed(routeSteps);
            break;
          case 'SelectProfile':
            Get.toNamed(routeProfiles);
            break;
          case 'OpenHome':
            Get.toNamed(routeScreen);
            break;
          default:
            Get.offAllNamed(routeLogin);
        }
      },
      // ignore: always_specify_types
      onError: (error) {
        // authStorage.clearAuthData();
        Get.toNamed(routeLogin);
        return null;
      },
    );
  }

  // List<dynamic> profiles = <dynamic>[];
  // Future<void> loadPatientsFromStorage() async {
  //   final String? userJson = await localStorage.readFromStorage(
  //     storageUserData,
  //   );
  //   if (userJson != null) {
  //     final Map<String, dynamic> userMap = jsonDecode(userJson);
  //     profiles = userMap['patients'] ?? <dynamic>[];
  //     update();
  //   }
  // }

  void updatePage(String newResolution) {
    page = newResolution;
    update();
  }

  Future<void> handleLogin() async {
    isLoading = true;
    update();

    final String phone = phoneNumberController.text.trim();

    if (showPage == 'forgetPassword') {
      showPathMobileRegistered = forgotPassword;
      update();
    } else {
      showPathMobileRegistered = pathMobileRegistered;
      update();
    }
    await ApiRequest(
      path: showPathMobileRegistered,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, dynamic>{mobile: phone},
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        final String? nextStep = response['nextStepEnum']?.toString();
        if (nextStep == 'Login') {
          linePercentage = 0.6;
          page = 'signIn';
          Get.to(() => const PatternLock());
          update();
        } else if (nextStep == 'OtpConfirm') {
          updatePage('signUp');
          Get.to(() => CustomOtp());
        } else if (nextStep == 'CreatePassword') {
          final StartStepsController steps = Get.find();
          steps.currentStep = 2;
          updatePage('signUp');
          Get.toNamed(routeSteps);
        }

        isLoading = false;
        showPhoneNumberError = false;
        passNumberPhone = phone;
        phoneNumberController.clear();
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        isLoading = false;

        phone.isEmpty
            ? phoneErrorMessage = 'is_emit_vaild'.tr
            : !phone.startsWith('+')
            ? phoneErrorMessage = 'is_emit_vaild_number_plus'.tr
            : !RegExp(r'^\+\d{1,4}-\d{6,10}$').hasMatch(phone)
            ? phoneErrorMessage = 'is_emit_vaild_check_number'.tr
            : error is DioException && error.response?.statusCode == 404
            ? phoneErrorMessage = 'is_emit_vaild_number_emit'.tr
            : phoneErrorMessage = 'is_vaild_error'.tr;

        showPhoneNumberError = true;
        update();
        return null;
      },
    );
  }

  void resetPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();
  }

  void updatePattern(List<int> pattern) {
    inputPattern = pattern;
    update();
  }

  // Future<String?> getFcmToken() async {
  //   try {
  //     final String? token = await FirebaseMessaging.instance.getToken();
  //     debugPrint('FCM token: $token');
  //     return token;
  //   } on FirebaseException catch (e, s) {
  //     debugPrint('FirebaseException while getting FCM token: $e\n$s');
  //     return null;
  //   } catch (e, s) {
  //     debugPrint('Unknown error while getting FCM token: $e\n$s');
  //     return null;
  //   }
  // }

  // Future<void> fetchAndStoreFcmToken() async {
  //   fcmToken = await getFcmToken();
  //   update();
  // }

  Future<void> validatePattern() async {
    isLoading = true;
    update();
    // final String? token = fcmToken ?? await getFcmToken();

    await ApiRequest(
      path: login,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, dynamic>{
        mobile: passNumberPhone,
        password: inputPattern.join(),
        // if (token != null) 'fcm_token': token,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        final String? nextStep = response['nextStepEnum']?.toString();
        final AuthStorageController authStorage = Get.find();
        await authStorage.saveAuthData(response['data']);
        final Map<String, VoidCallback> nextStepActions =
            <String, VoidCallback>{
              'CreateProfile': () {
                final StartStepsController steps = Get.find();
                steps.currentStep = 3;
                steps.update();
                Get.toNamed(routeSteps);
              },
              'SelectProfile': () => Get.toNamed(routeProfiles),
              'OpenHome': () => Get.toNamed(routeScreen),
            };

        if (nextStep != null && nextStepActions.containsKey(nextStep)) {
          nextStepActions[nextStep]!();
        }
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        state = PatternState.error;
        isLoading = false;
        showForgetPatter = true;
        update();
        return null;
      },
    );
  }

  void createVerificationForExistingUser() {
    if (page == 'update') {
      if (inputPattern.isNotEmpty) {
        tempSavedPattern = <int>[...inputPattern];
        resetPattern();
        updatePage('verifyPattern');
        state = PatternState.success;
        update();
      }
    } else if (page == 'verifyPattern') {
      if (listEquals(tempSavedPattern, inputPattern)) {
        state = PatternState.success;
        update();
        page = 'signIn';
        resetPattern();
      } else {
        state = PatternState.error;
        update();
        updatePage('update');
      }
    }
  }

  void startPattern() {
    inputPattern.clear();
    state = PatternState.normal;
    update();

    // ignore: always_specify_types
    Future.delayed(const Duration(milliseconds: 50), () {
      state = PatternState.active;
      update();
    });
  }
}
