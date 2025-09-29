import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  List<int> tempSavedPattern = <int>[];

  String page = 'signIn';
  String phoneErrorMessage = '';
  String passNumberPhone = '';

  bool showPhoneNumberError = false;
  double linePercentage = 0.0;

  // check pass about data if true open the user and open response users and loop to users and view to list view
  List<int> inputPattern = <int>[];
  PatternState state = PatternState.normal;
  bool showForgetPatter = false;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;

  // check pass about data if true open the user and open response users and loop to users and view to list view
  final List<Map<String, dynamic>> profiles = <Map<String, dynamic>>[
    <String, dynamic>{'id': 1, 'icon': iconUser, 'name': 'name_user'.tr},
  ];

  void updatePage(String newResolution) {
    page = newResolution;
    update();
  }

  Future<void> handleLogin() async {
    isLoading = true;
    update();

    final String phone = phoneNumberController.text.trim();

    await ApiRequest(
      path: pathMobileRegistered,
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
          Get.to(() => PatternLock());
          update();
        } else if (nextStep == 'OtpConfirm') {
          updatePage('signUp');
          Get.to(() => CustomOtp());
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

  // bool isLoginRequestValid(List<Map<String, dynamic>> loginData) {
  //   if (loginData.isEmpty) {
  //     return false;
  //   }

  //   final Map<String, dynamic> data = loginData.first;
  //   final String? mobile = data['mobile'];
  //   final String? password = data['password'];
  //   if (mobile == null || mobile.trim().isEmpty) {
  //     return false;
  //   }
  //   if (password == null || password.trim().isEmpty) {
  //     return false;
  //   }
  //   if (mobile.length < 7 || mobile.length > 11) {
  //     return false;
  //   }
  //   if (password.length < 4) {
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> validatePattern() async {
    isLoading = true;
    update();

    await ApiRequest(
      path: login,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, dynamic>{
        mobile: passNumberPhone,
        password: inputPattern.join(),
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        final String? nextStep = response['nextStepEnum']?.toString();
        if (nextStep == 'CreateProfile') {
          // final String? accessToken = response['accessToken']?.toString();
          final String? refreshToken = response['data']?['refreshToken']
              ?.toString();
          await localStorage.saveToStorage(
            key: storageRefreshToken,
            value: refreshToken,
          );
          await localStorage.readFromStorage(storageRefreshToken);
        }
        Get.toNamed(routeScreen);
        showForgetPatter = false;
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

    // final List<Map<String, dynamic>> login = <Map<String, dynamic>>[
    //   <String, dynamic>{
    //     'mobile': phoneNumberController.text.trim(),
    //     'password': inputPattern.join(),
    //   },
    // ];

    // if (isLoginRequestValid(login)) {
    // //   // if profiles not empty open page profiles and save refresh token in localstorage
    // //   // if profiles empty open register name and type and date
    // //   if (profiles.isEmpty) {
    // //     // if response i have token save response refresh token in localstorage
    // //     // localStorage.saveToStorage(
    // //     //   key: storageRefreshToken,
    // //     //   value: 'responseRefreshToken',
    // //     // );
    // //     Get.to(() => FormDataUser(isFromProfile: false));
    // //   } else {
    // //     Get.toNamed(routeProfiles);
    // //   }
    // //   consoleLog(
    // //     'id: 1, mobile ${phoneNumberController.text} role $inputPattern status 1 and profiles access token refresh token',
    // //   );
    // } else {
    //   state = PatternState.error;
    //   showForgetPatter = true;
    //   update();
    // }
  }

  // create verification for existingUser about user
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
        consoleLog(tempSavedPattern);
        // here response user data and access token and refresh token
        // final List<Map<String, dynamic>> login = <Map<String, dynamic>>[
        //   <String, dynamic>{
        //     'mobile': PhoneNumberController.text.trim(),
        //     'password': inputPattern.join(),
        //     'createPasswordToken': 'توكن الإنشاء (نص)',
        //   },
        // ];
        page = 'signIn';
        if (profiles.isEmpty) {
          page = 'signIn';
        } else {
          Get.toNamed(routeLogin);
        }
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

    Future.delayed(const Duration(milliseconds: 50), () {
      state = PatternState.active;
      update();
    });
  }
}
