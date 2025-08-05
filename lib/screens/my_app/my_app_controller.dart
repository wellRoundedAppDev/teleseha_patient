import 'dart:async';
// import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;
  dynamic lovData;
  dynamic response;
  String otp = '';
  AuthType authType = AuthType.signIn;
  int seconds = 120;
  Timer? otpTimer;
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyEnNameController = TextEditingController();
  TextEditingController companyArNameController = TextEditingController();
  TextEditingController companyRegistrationNumber = TextEditingController();
  TextEditingController companyEmail = TextEditingController();
  bool isCompanySelected = true;
  String displayedBidderName = '';

  /// This action is a success action filled when the user wants to do something and he is not logged in,
  /// we will save this action here and implement it after success login otp
  Function()? successAction;

  @override
  Future<void> onInit() async {
    super.onInit();
    userData = await localStorage.getFromStorage(key: storeLocationPermission);
    displayedBidderName =
        await localStorage.getFromStorage(key: storeLocationPermission) ?? '';

    consoleLog(userData, key: 'userData');

    timer();
  }

  @override
  void onReady() {
    super.onReady();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      versionName = packageInfo.version;
      final List<String> splitVersionNumber = versionName!.split('.');
      if (splitVersionNumber.length > 2) {
        splitVersionNumber.removeAt(2);
        versionName = splitVersionNumber.join('.');
      }
      consoleLog(versionName, key: 'versionName');
      buildNumber = packageInfo.buildNumber;
      update();
    });
    getAllItems();
  }

  void getAllItems() {
    startLoading();
    ApiRequest(
      path: users,
      className: 'MapScreenController',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        this.response = response;
        update();
      },
    );
  }

  void onUserAuthenticated(dynamic userDataValue) {
    localStorage.saveToStorage(
      key: storeLocationPermission,
      value: userDataValue,
    );
    userData = userDataValue;
    localStorage.saveToStorage(key: name, value: userData[name]);
    consoleLog('onUserAuthenticated$userData');
    update();
    if (Get.isRegistered<HomeBottomBarController>()) {
      Get.find<HomeBottomBarController>();
    }
  }

  void changeShowNoInternetDialogState(dynamic newValue) {
    shouldShowNoInternetDialog = newValue;
    update();
  }

  void onUserUpdated(dynamic userDataValue) {
    localStorage.saveToStorage(
      key: storeLocationPermission,
      value: userDataValue,
    );
    userData = userDataValue;
    consoleLog(userDataValue);
    update();
  }

  void onDisplayedUserNameUpdate(String value) {
    localStorage.saveToStorage(key: name, value: value);
    displayedBidderName = value;
    update();
  }

  Timer timer({bool isClose = false}) =>
      Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (isClose) {
          timer.cancel();
        }
      });

  void onSignOut() {
    localStorage.erase();
    userData = null;
    if (Get.isRegistered<HomeBottomBarController>()) {
      Get.find<HomeBottomBarController>();
    }
    update();
  }

  Future<void> lov({dynamic onDataFetched}) async {
    await ApiRequest(
      path: users,
      className: 'MyAppController',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        onLovUpdated(data);
        if (onDataFetched != null) {
          onDataFetched();
        }
      },
    );
  }

  void onLovUpdated(dynamic newValue) {
    localStorage.saveToStorage(key: name, value: newValue);
    lovData = newValue;
  }

  String getSetOptionValue(String code) {
    final List<dynamic> setOptions = lovData[name]
        .where((dynamic element) => element[name] == code)
        .toList();
    if (setOptions.isNotEmpty) {
      return setOptions[0][name];
    }
    return '';
  }

  String getFontFamily(String languageCode) {
    String fontFamily = 'Outfit-light';

    if (languageCode.toLowerCase() == 'ar') {
      fontFamily = 'Outfit-light';
    }

    return fontFamily;
  }

  Future<void> preSignIn({bool shouldOpenCodeVerificationSheet = true}) async {
    if (phoneController.text.isEmpty) {
      showToast(message: 'please_enter_phone_number'.tr);
      return;
    }
    startLoading();
    ApiRequest(
      path: users,
      method: ApiMethods.post,
      className: 'MyAppController/preSignIn',
      header: <String, dynamic>{name: '+966${phoneController.text}'},
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        if (response[name] == '1') {
          if (shouldOpenCodeVerificationSheet) {
            openCodeVerificationSheet();
          }
        } else {
          showToast(message: response?[name] ?? 'Error');
        }
      },
    );
  }

  Future<void> auth() async {
    if (otp.length != 5) {
      showToast(message: 'please_enter_verification_code'.tr);
      return;
    }
    startLoading();
    final String fcId = await FirebaseMessaging.instance.getToken() ?? '';
    ApiRequest(
      path: (authType == AuthType.signIn ? users : users),
      method: ApiMethods.post,
      className: 'MyAppController/signIn',
      header: <String, dynamic>{name: '+966${phoneController.text}'},
      queryParameters: <String, dynamic>{
        name: authType == AuthType.signUp
            ? !isCompanySelected
                  ? firstNameController.text
                  : null
            : '',
        name: authType == AuthType.signUp
            ? !isCompanySelected
                  ? lastNameController.text
                  : null
            : '',
        name: authType == AuthType.signUp ? companyEnNameController.text : null,
        name: authType == AuthType.signUp ? companyArNameController.text : null,
        name: authType == AuthType.signUp
            ? companyRegistrationNumber.text
            : null,
        name: authType == AuthType.signUp ? companyEmail.text : null,
        name: authType == AuthType.signUp
            ? isCompanySelected
                  ? '1'
                  : '0'
            : null,
        name: fcId,
        name: otp,
      },
    ).request(
      onSuccessWithHeader: (dynamic data, dynamic response, dynamic headers) {
        dismissLoading();
        if (response[name] == '1') {
          Future<void>.delayed(const Duration(milliseconds: 500), Get.back);
          if (!response.containsKey(name)) {
            response[name] = headers[name][0];
          }
          onUserAuthenticated(response);
          showToast(message: response?[name] ?? 'Done');
          if (successAction != null) {
            successAction?.call();
          }
        } else {
          showToast(message: response?[name] ?? 'Error');
        }
      },
    );
  }

  // void preSignUp({bool shouldOpenCodeVerificationSheet = true}) {
  //   if (!isCompanySelected) {
  //     if (firstNameController.text.isEmpty) {
  //       showToast(message: 'please_enter_first_name'.tr);
  //       return;
  //     }
  //     if (lastNameController.text.isEmpty) {
  //       showToast(message: 'please_enter_last_name'.tr);
  //       return;
  //     }
  //   } else {
  //     if (companyEnNameController.text.isEmpty) {
  //       showToast(message: 'please_enter_english_company_name'.tr);
  //       return;
  //     }
  //     if (companyArNameController.text.isEmpty) {
  //       showToast(message: 'please_enter_arabic_company_name'.tr);
  //       return;
  //     }
  //     if (companyRegistrationNumber.text.isEmpty) {
  //       showToast(message: 'please_enter_commercial_registration_no'.tr);
  //       return;
  //     }
  //     if (companyEmail.text.isEmpty) {
  //       showToast(message: 'please_enter_email'.tr);
  //       return;
  //     }
  //   }
  //   startLoading();
  //   ApiRequest(
  //     path: users,
  //     method: ApiMethods.post,
  //     className: 'MyAppController/preSignIn',
  //     header: <String, dynamic>{name: '+966${phoneController.text}'},
  //     // queryParameters: <String, dynamic>{
  //     //   keyFirstName: firstNameController.text,
  //     //   keyLastName: lastNameController.text,
  //     //   keyIsCompany: isCompanySelected ? '1' : '0',
  //     // },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) {
  //       dismissLoading();
  //       if (response[name] == '1') {
  //         if (shouldOpenCodeVerificationSheet) {
  //           openCodeVerificationSheet();
  //         }
  //       } else {
  //         showToast(message: response?[name] ?? 'Error');
  //       }
  //     },
  //   );
  // }

  void openSignInSheet({Function()? action}) {
    if (action != null) {
      successAction = action;
    } else {
      successAction = null;
    }

    authType = AuthType.signIn;
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }

  void openSignUpSheet({Function()? action}) {
    authType = AuthType.signUp;
    resetAuthInputs();
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }

  Future<void> openCodeVerificationSheet() async {
    seconds = 120;
    startTimer();
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }

    Get.bottomSheet(
      BottomSheetContainer(
        title: 'otp_verification'.tr,
        child: const CodeVerificationSheet(),
      ),
      isScrollControlled: true,
    );
  }

  void resendCode() {
    if (seconds == 0) {
      seconds = 120;
      startTimer();
      if (authType == AuthType.signIn) {
        preSignIn(shouldOpenCodeVerificationSheet: false);
      } else {
        // preSignUp(shouldOpenCodeVerificationSheet: false);
      }
    }
  }

  void resetAuthInputs() {
    phoneController.clear();
    firstNameController.clear();
    lastNameController.clear();
    otp = '';
  }

  void startTimer() {
    otpTimer?.cancel();
    const Duration oneSec = Duration(seconds: 1);
    otpTimer = Timer.periodic(oneSec, (Timer timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        seconds--;
        update();
      }
    });
  }

  void addRemoveFavorite(
    dynamic objectType,
    dynamic objectId, {
    Function()? action,
  }) {
    if (userData == null) {
      openSignInSheet(
        action: () {
          if (action != null) {
            action.call();
          }
          onAddOrRemoveFromFavorite(objectType, objectId);
        },
      );
    } else {
      onAddOrRemoveFromFavorite(objectType, objectId);
    }
  }

  void onAddOrRemoveFromFavorite(dynamic objectType, dynamic objectId) {
    startLoading();
    ApiRequest(
      className: 'MyAppController/addRemoveFavorite',
      method: ApiMethods.post,
      path: '$users?$users=$objectId&$users=$objectType',
      queryParameters: <String, dynamic>{name: userData[name]},
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        consoleLog(Get.currentRoute, key: 'Get.currentRoute');
        if (Get.find<HomeBottomBarController>().bottomBarIndex == 0) {
          Get.find<HomeController>().getHomeData();
        }
        dismissLoading();
      },
    );
  }

  void onCompanyIndividualPress({String value = 'company'}) {
    isCompanySelected = value == 'company';
    update();
  }

  @override
  void onClose() {
    super.onClose();
    timer(isClose: true);
  }
}
