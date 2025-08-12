import 'dart:async';

import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int currentStep = 1;
  int numberOfStep = 4;
  bool use_biometric = false;
  String? selectedMaleCode = 'male';

  Rx<DateTime> selectedDate = DateTime.now().obs;
  TextEditingController dateController = TextEditingController();
  // TextEditingController TextfieldAge = TextEditingController();
  TextEditingController textfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();
  TextEditingController TextfieldPassword = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  // TextEditingController TextfieldChronicDiseases = TextEditingController();
  // TextEditingController TextfieldSurgicalOperations = TextEditingController();
  // TextEditingController TextfieldContinuousMedications =
  //     TextEditingController();
  // TextEditingController TextfieldAllergies = TextEditingController();

  bool isVaildAge = false;
  bool isVaildName = false;
  bool isVaildNumber = false;
  bool isVaildPassword = false;
  bool isOtpInvalid = false;

  // bool isVaildChronicDiseases = false;
  // bool isVaildSurgicalOperations = false;
  // bool isVaildContinuousMedications = false;
  // bool isVaildAllergies = false;

  int secondsRemaining = 70;
  Timer? timer;

  List<Map<String, String>> typeGenrate = [
    {gender: 'female'.tr, icon: iconFemale, code: 'female'},
    {gender: 'male'.tr, icon: iconMale, code: 'male'},
  ];

  void minuseSelectedSteps() {
    currentStep--;
    textfieldName.clear();
    update();
  }

  void changeTypeGenrate(String typeCode) {
    selectedMaleCode = typeCode;
    update();
  }

  Future<void> checkBiometrics() async {
    final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
    if (!canAuthenticateWithBiometrics) {
      // Fluttertoast.showToast(msg: 'Devices is not supoprt biometrics');
      return;
    }

    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      // Fluttertoast.showToast(
      //   msg:
      //       'Biometrics is empty, please set up Biometrics in devices settings',
      // );
      return;
    }

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'please_auth_finger_print'.tr,
      );
      if (didAuthenticate) {
        use_biometric = true;
        currentStep++;
        update();
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
    }
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = picked;
      final formattedDate =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
      dateController.text = formattedDate;
      update();
    } else {
      print('❌ Date picker dismissed');
    }
  }

  bool checkVaildsSteps() {
    bool isValid = true;

    if (currentStep == 1) {
      if (textfieldName.text.isEmpty) {
        isVaildName = true;
        isValid = false;
      } else {
        isVaildName = false;
      }
    }

    if (currentStep == 2) {
      if (!checkOtpIsValid()) {
        isValid = false;
        markOtpInvalid();
      } else {
        Get.toNamed(routeCreateAccountSuccess);
        clearOtpError();
        consoleLog('OTP Entered: ${otpController.text}');
      }
    }

    if (currentStep == 3) {
      if (TextfieldNumber.text.isEmpty && TextfieldPassword.text.isEmpty) {
        isValid = false;
      }

      if (TextfieldNumber.text.isEmpty) {
        isVaildPassword = true;
        isValid = false;
      } else {
        isVaildPassword = false;
      }

      if (TextfieldPassword.text.isEmpty) {
        isVaildNumber = true;
        isValid = false;
      } else {
        isVaildNumber = false;
      }
    }

    update();
    return isValid;
  }

  // bool dedical_history() {
  //   bool isValid = true;

  //   if (TextfieldChronicDiseases.text.isEmpty) {
  //     isVaildChronicDiseases = true;
  //     isValid = false;
  //   } else {
  //     isVaildChronicDiseases = false;
  //   }

  //   if (TextfieldSurgicalOperations.text.isEmpty) {
  //     isVaildSurgicalOperations = true;
  //     isValid = false;
  //   } else {
  //     isVaildSurgicalOperations = false;
  //   }

  //   if (TextfieldContinuousMedications.text.isEmpty) {
  //     isVaildContinuousMedications = true;
  //     isValid = false;
  //   } else {
  //     isVaildContinuousMedications = false;
  //   }

  //   if (TextfieldAllergies.text.isEmpty) {
  //     isVaildAllergies = true;
  //     isValid = false;
  //   } else {
  //     isVaildAllergies = false;
  //   }

  //   update();
  //   return isValid;
  // }

  //   bool canGoToStepTwo() {
  //     return isPasswordValid;
  //   }

  //   bool canGoToStepThree() {
  //     isValidName = textfieldName.text.isNotEmpty;
  //     isValidDateOfBirth = TextfieldAge.text.isNotEmpty;
  //     update();
  //     return isValidName && isValidDateOfBirth;
  //   }

  //   void onNextButtonPress() {
  //     // last page
  //     if (currentStep == numberOfAllSteps) {
  //        Get.toNamed(routeCreateAccountSuccess);
  //         clearOtpError();
  //         consoleLog('OTP Entered: ${otpController.text}');
  //     } else {
  //       if (currentStep == 1) {
  //         // Backend checked if password is correct or not
  //         if (passwordChecked) {
  //           if (canGoToStepTwo()) {
  //             ++currentStep;
  //             update();
  //           } else {
  //            // showMessage(description: 'password_not_correct'.tr);
  //           }
  //         } else {
  //           // Do api call to check password
  //         }
  //       } else if (currentStep == 2) {
  //         if (Get.find<MyAppController>().userData == null) {
  //           // Open register screen
  //         } else {
  //           // open otp screen
  //         }
  //       }
  //     }
  //   }

  // This is the otp timer logic
  // create request post and data user and save storage to data user

  void startTimerManually() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
  }

  void restartTimer() {
    timer?.cancel();
    secondsRemaining = 70;
    update();
    startCountdown();
    consoleLog('تمت إعادة إرسال الكود');
  }

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        update();
      } else {
        timer.cancel();
        onTimeFinished();
      }
    });
  }

  void onTimeFinished() {
    consoleLog('انتهى الوقت');
  }

  String get formattedTime {
    final minutes = secondsRemaining ~/ 60;
    final secs = secondsRemaining % 60;
    return '[$minutes:${secs.toString().padLeft(2, '0')}]';
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    otpController.dispose();
  }

  void consoleLogOtp() {
    consoleLog('📥 OTP Entered: ${otpController.text}');
  }

  void markOtpInvalid() {
    isOtpInvalid = true;
    update();
  }

  void clearOtpError() {
    isOtpInvalid = false;
    update();
  }

  bool checkOtpIsValid() {
    return otpController.text.length == 6;
  }
}

// // import 'dart:async';

// // import '../../../general_exports.dart';

// // class StartStepsController extends GetxController {
// //   int currentStep = 1;
// //   int numberOfAllSteps = 4;
// //   bool use_biometric = false;
// //   String? selectedMaleCode = 'male';

// //   Rx<DateTime> selectedDate = DateTime.now().obs;
// //   TextEditingController dateController = TextEditingController();
// //   // TextEditingController TextfieldAge = TextEditingController();
// //   TextEditingController textfieldName = TextEditingController();
// //   TextEditingController TextfieldNumber = TextEditingController();
// //   TextEditingController TextfieldPassword = TextEditingController();
// //   TextEditingController otpController = TextEditingController();

// //   final LocalAuthentication auth = LocalAuthentication();

// //   // TextEditingController TextfieldChronicDiseases = TextEditingController();
// //   // TextEditingController TextfieldSurgicalOperations = TextEditingController();
// //   // TextEditingController TextfieldContinuousMedications =
// //   //     TextEditingController();
// //   // TextEditingController TextfieldAllergies = TextEditingController();

// //   bool isVaildAge = false;
// //   bool isVaildName = false;
// //   bool isVaildNumber = false;
// //   bool isVaildPassword = false;
// //   bool isVaildMessageOtp = false;

// //   // bool isVaildChronicDiseases = false;
// //   // bool isVaildSurgicalOperations = false;
// //   // bool isVaildContinuousMedications = false;
// //   // bool isVaildAllergies = false;

// //   int secondsRemaining = 70;
// //   Timer? timer;

// //   List<Map<String, String>> typeGenrate = [
// //     {gender: 'female'.tr, icon: iconFemale, code: 'female'},
// //     {gender: 'male'.tr, icon: iconMale, code: 'male'},
// //   ];

// //   void minuseSelectedSteps() {
// //     currentStep--;
// //     update();
// //   }

// //   void changeTypeGenrate(String typeCode) {
// //     selectedMaleCode = typeCode;
// //     update();
// //   }

// //   Future<void> checkBiometrics() async {
// //     final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
// //     if (!canAuthenticateWithBiometrics) {
// //       Fluttertoast.showToast(msg: 'Devices is not supoprt biometrics');
// //       return;
// //     }

// //     final List<BiometricType> availableBiometrics = await auth
// //         .getAvailableBiometrics();

// //     if (availableBiometrics.isEmpty) {
// //       Fluttertoast.showToast(
// //         msg:
// //             'Biometrics is empty, please set up Biometrics in devices settings',
// //       );
// //       return;
// //     }

// //     try {
// //       final bool didAuthenticate = await auth.authenticate(
// //         localizedReason: 'please_auth_finger_print'.tr,
// //       );
// //       if (didAuthenticate) {
// //         use_biometric = true;
// //         currentStep++;
// //         update();
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
// //     }
// //   }

// //   void pickDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: selectedDate.value,
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime.now(),
// //     );

// //     if (picked != null) {
// //       selectedDate.value = picked;
// //       final formattedDate =
// //           '${picked.day.toString().padLeft(2, '0')}-'
// //           '${picked.month.toString().padLeft(2, '0')}-'
// //           '${picked.year}';
// //       dateController.text = formattedDate;
// //       update();
// //     } else {
// //       print('❌ Date picker dismissed');
// //     }
// //   }

// //   bool checkAllVaildsSteps() {
// //     bool isValid = true;

// //     if (currentStep == 2) {
// //       //  && TextfieldAge.text.isEmpty
// //       if (textfieldName.text.isNotEmpty) {
// //         isValid = false;
// //       }

// //       if (textfieldName.text.isEmpty) {
// //         isVaildName = true;
// //         isValid = false;
// //       } else {
// //         isVaildName = false;
// //       }

// //       // if (TextfieldAge.text.isEmpty) {
// //       //   isVaildAge = true;
// //       //   isValid = false;
// //       // } else {
// //       //   isVaildAge = false;
// //       // }
// //     }

// //     if (currentStep == 3) {
// //       if (TextfieldNumber.text.isEmpty && TextfieldPassword.text.isEmpty) {
// //         isValid = false;
// //       }

// //       if (TextfieldNumber.text.isEmpty) {
// //         isVaildPassword = true;
// //         isValid = false;
// //       } else {
// //         isVaildPassword = false;
// //       }

// //       if (TextfieldPassword.text.isEmpty) {
// //         isVaildNumber = true;
// //         isValid = false;
// //       } else {
// //         isVaildNumber = false;
// //       }
// //     }

// //     if (currentStep == 4) {
// //       if (!checkOtpIsValid()) {
// //         isValid = false;
// //         markOtpInvalid();
// //       } else {
// //         Get.toNamed(routeCreateAccountSuccess);
// //         clearOtpError();
// //         consoleLog('OTP Entered: ${otpController.text}');
// //       }
// //     }

// //     update();
// //     return isValid;
// //   }

// //   // bool dedical_history() {
// //   //   bool isValid = true;

// //   //   if (TextfieldChronicDiseases.text.isEmpty) {
// //   //     isVaildChronicDiseases = true;
// //   //     isValid = false;
// //   //   } else {
// //   //     isVaildChronicDiseases = false;
// //   //   }

// //   //   if (TextfieldSurgicalOperations.text.isEmpty) {
// //   //     isVaildSurgicalOperations = true;
// //   //     isValid = false;
// //   //   } else {
// //   //     isVaildSurgicalOperations = false;
// //   //   }

// //   //   if (TextfieldContinuousMedications.text.isEmpty) {
// //   //     isVaildContinuousMedications = true;
// //   //     isValid = false;
// //   //   } else {
// //   //     isVaildContinuousMedications = false;
// //   //   }

// //   //   if (TextfieldAllergies.text.isEmpty) {
// //   //     isVaildAllergies = true;
// //   //     isValid = false;
// //   //   } else {
// //   //     isVaildAllergies = false;
// //   //   }

// //   //   update();
// //   //   return isValid;
// //   // }

// //   //   bool canGoToStepTwo() {
// //   //     return isPasswordValid;
// //   //   }

// //   //   bool canGoToStepThree() {
// //   //     isValidName = textfieldName.text.isNotEmpty;
// //   //     isValidDateOfBirth = TextfieldAge.text.isNotEmpty;
// //   //     update();
// //   //     return isValidName && isValidDateOfBirth;
// //   //   }

// //   //   void onNextButtonPress() {
// //   //     // last page
// //   //     if (currentStep == numberOfAllSteps) {
// //   //        Get.toNamed(routeCreateAccountSuccess);
// //   //         clearOtpError();
// //   //         consoleLog('OTP Entered: ${otpController.text}');
// //   //     } else {
// //   //       if (currentStep == 1) {
// //   //         // Backend checked if password is correct or not
// //   //         if (passwordChecked) {
// //   //           if (canGoToStepTwo()) {
// //   //             ++currentStep;
// //   //             update();
// //   //           } else {
// //   //            // showMessage(description: 'password_not_correct'.tr);
// //   //           }
// //   //         } else {
// //   //           // Do api call to check password
// //   //         }
// //   //       } else if (currentStep == 2) {
// //   //         if (Get.find<MyAppController>().userData == null) {
// //   //           // Open register screen
// //   //         } else {
// //   //           // open otp screen
// //   //         }
// //   //       }
// //   //     }
// //   //   }

// //   // This is the otp timer logic
// //   // create request post and data user and save storage to data user

// //   void startTimerManually() {
// //     timer?.cancel();
// //     secondsRemaining = 70;
// //     update();
// //     startCountdown();
// //   }

// //   void restartTimer() {
// //     timer?.cancel();
// //     secondsRemaining = 70;
// //     update();
// //     startCountdown();
// //     consoleLog('تمت إعادة إرسال الكود');
// //   }

// //   void startCountdown() {
// //     timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       if (secondsRemaining > 0) {
// //         secondsRemaining--;
// //         update();
// //       } else {
// //         timer.cancel();
// //         onTimeFinished();
// //       }
// //     });
// //   }

// //   void onTimeFinished() {
// //     consoleLog('انتهى الوقت');
// //   }

// //   String get formattedTime {
// //     final minutes = secondsRemaining ~/ 60;
// //     final secs = secondsRemaining % 60;
// //     return '[$minutes:${secs.toString().padLeft(2, '0')}]';
// //   }

// //   @override
// //   void onClose() {
// //     super.onClose();
// //     timer?.cancel();
// //     otpController.dispose();
// //   }

// //   void consoleLogOtp() {
// //     consoleLog('📥 OTP Entered: ${otpController.text}');
// //   }

// //   void markOtpInvalid() {
// //     isVaildMessageOtp = true;
// //     update();
// //   }

// //   void clearOtpError() {
// //     isVaildMessageOtp = false;
// //     update();
// //   }

// //   bool checkOtpIsValid() {
// //     return otpController.text.length == 6;
// //   }
// // }

// import 'dart:async';

// import '../../../general_exports.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class StartStepsController extends GetxController {
//   int currentStep = 1;
//   int numberOfStep = 4;
//   bool useBiometric = false;
//   String? selectedMaleCode = 'male';

//   Rx<DateTime> selectedDate = DateTime.now().obs;
//   TextEditingController dateController = TextEditingController();
//   // TextEditingController TextfieldAge = TextEditingController();
//   TextEditingController textfieldName = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController TextfieldPassword = TextEditingController();
//   TextEditingController otpController = TextEditingController();

//   final LocalAuthentication auth = LocalAuthentication();

//   // TextEditingController TextfieldChronicDiseases = TextEditingController();
//   // TextEditingController TextfieldSurgicalOperations = TextEditingController();
//   // TextEditingController TextfieldContinuousMedications =
//   //     TextEditingController();
//   // TextEditingController TextfieldAllergies = TextEditingController();

//   bool isVaildMessageOtp = false;
//   // bool isVaildName = false;
//   // bool isVaildNumber = false;
//   // bool isVaildPassword = false;

//   // bool isVaildChronicDiseases = false;
//   // bool isVaildSurgicalOperations = false;
//   // bool isVaildContinuousMedications = false;
//   // bool isVaildAllergies = false;

//   int secondsRemaining = 70;
//   Timer? timer;

//   List<Map<String, String>> typeGenrate = [
//     {gender: 'female'.tr, icon: iconFemale, code: 'female'},
//     {gender: 'male'.tr, icon: iconMale, code: 'male'},
//   ];

//   void minuseSelectedSteps() {
//     currentStep--;
//     update();
//   }

//   void changeTypeGenrate(String typeCode) {
//     selectedMaleCode = typeCode;
//     update();
//   }

//   Future<void> checkBiometrics() async {
//     final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
//     if (!canAuthenticateWithBiometrics) {
//       Fluttertoast.showToast(msg: 'Devices is not supoprt biometrics');
//       return;
//     }

//     final List<BiometricType> availableBiometrics = await auth
//         .getAvailableBiometrics();

//     if (availableBiometrics.isEmpty) {
//       Fluttertoast.showToast(
//         msg:
//             'Biometrics is empty, please set up Biometrics in devices settings',
//       );
//       return;
//     }

//     try {
//       final bool didAuthenticate = await auth.authenticate(
//         localizedReason: 'please_auth_finger_print'.tr,
//       );
//       if (didAuthenticate) {
//         useBiometric = true;
//         currentStep++;
//         update();
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
//     }
//   }

//   void pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       selectedDate.value = picked;
//       final formattedDate =
//           '${picked.day.toString().padLeft(2, '0')}-'
//           '${picked.month.toString().padLeft(2, '0')}-'
//           '${picked.year}';
//       dateController.text = formattedDate;
//       update();
//     } else {
//       print('❌ Date picker dismissed');
//     }
//   }

//   // bool checkAllVaildsSteps() {
//   //   bool isValid = true;

//   //   if (currentStep == 2) {
//   //     //  && TextfieldAge.text.isEmpty
//   //     if (textfieldName.text.isNotEmpty) {
//   //       isValid = false;
//   //     }

//   //     if (textfieldName.text.isEmpty) {
//   //       isVaildName = true;
//   //       isValid = false;
//   //     } else {
//   //       isVaildName = false;
//   //     }

//   //     // if (TextfieldAge.text.isEmpty) {
//   //     //   isVaildAge = true;
//   //     //   isValid = false;
//   //     // } else {
//   //     //   isVaildAge = false;
//   //     // }
//   //   }

//   //   if (currentStep == 3) {
//   //     if (TextfieldNumber.text.isEmpty && TextfieldPassword.text.isEmpty) {
//   //       isValid = false;
//   //     }

//   //     if (TextfieldNumber.text.isEmpty) {
//   //       isVaildPassword = true;
//   //       isValid = false;
//   //     } else {
//   //       isVaildPassword = false;
//   //     }

//   //     if (TextfieldPassword.text.isEmpty) {
//   //       isVaildNumber = true;
//   //       isValid = false;
//   //     } else {
//   //       isVaildNumber = false;
//   //     }
//   //   }

//   //   if (currentStep == 4) {
//   //     if (!checkOtpIsValid()) {
//   //       isValid = false;
//   //       markOtpInvalid();
//   //     } else {
//   //       Get.toNamed(routeCreateAccountSuccess);
//   //       clearOtpError();
//   //       consoleLog('OTP Entered: ${otpController.text}');
//   //     }
//   //   }

//   //   update();
//   //   return isValid;
//   // }

//   // bool dedical_history() {
//   //   bool isValid = true;

//   //   if (TextfieldChronicDiseases.text.isEmpty) {
//   //     isVaildChronicDiseases = true;
//   //     isValid = false;
//   //   } else {
//   //     isVaildChronicDiseases = false;
//   //   }

//   //   if (TextfieldSurgicalOperations.text.isEmpty) {
//   //     isVaildSurgicalOperations = true;
//   //     isValid = false;
//   //   } else {
//   //     isVaildSurgicalOperations = false;
//   //   }

//   //   if (TextfieldContinuousMedications.text.isEmpty) {
//   //     isVaildContinuousMedications = true;
//   //     isValid = false;
//   //   } else {
//   //     isVaildContinuousMedications = false;
//   //   }

//   //   if (TextfieldAllergies.text.isEmpty) {
//   //     isVaildAllergies = true;
//   //     isValid = false;
//   //   } else {
//   //     isVaildAllergies = false;
//   //   }

//   //   update();
//   //   return isValid;
//   // }

//   bool canGoToStepTwo() {
//     if (phoneNumberController.text.isEmpty) {
//       showToast(message: 'is_vaild_number'.tr);
//       isVaildMessageOtp = false;
//       return false;
//     } else {
//       isVaildMessageOtp = true;
//       return true;
//     }
//   }

//   bool canGoToStepThree() {
//     if (!checkOtpIsValid()) {
//       markOtpInvalid();
//       return false;
//     } else {
//       clearOtpError();
//       consoleLog('OTP Entered: ${otpController.text}');
//       return true;
//     }
//   }

//   void clearOtpError() {
//     isVaildMessageOtp = false;
//     update();
//   }

//   // Get.find<MyAppController>().userData == null

//   void markOtpInvalid() {
//     isVaildMessageOtp = true;
//     update();
//   }

//   bool checkOtpIsValid() {
//     return otpController.text.length == 6;
//   }

//   void onNextButtonPress() {
//     if (currentStep == numberOfStep) {
//       // Get.toNamed(test);
//     } else {
//       if (currentStep == 1) {
//         if (canGoToStepTwo()) {
//           ++currentStep;
//           phoneNumberController.clear();
//           update();
//         }
//       } else if (currentStep == 2) {
//         if (canGoToStepThree()) {
//           ++currentStep;
//           update();
//         }
//       }
//     }
//   }

//   // void onNextButtonPress() {
//   //   if (currentStep == numberOfStep) {
//   //     //        Get.toNamed(test);
//   //   } else {
//   //     if (currentStep == 1) {
//   //       // post phone number request and get response and save to sharedpreferances
//   //       // get vaild or pettern number
//   //       if (canGoToStepTwo()) {
//   //         ++currentStep;
//   //         phoneNumberController.clear();
//   //         update();
//   //       }
//   //     }

//   //     // else if currentStep == 2
//   //     // post otp
//   //     // get response userdata if true open homepage if false open register
//   //     if (currentStep == 2) {
//   //       if (canGoToStepThree()) {
//   //         ++currentStep;
//   //         update();
//   //       }
//   //     }
//   //   }
//   // }

//   // This is the otp timer logic
//   // create request post and data user and save storage to data user

//   void startTimerManually() {
//     timer?.cancel();
//     secondsRemaining = 70;
//     update();
//     startCountdown();
//   }

//   void restartTimer() {
//     timer?.cancel();
//     secondsRemaining = 70;
//     update();
//     startCountdown();
//     consoleLog('تمت إعادة إرسال الكود');
//   }

//   void startCountdown() {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (secondsRemaining > 0) {
//         secondsRemaining--;
//         update();
//       } else {
//         timer.cancel();
//         onTimeFinished();
//       }
//     });
//   }

//   void onTimeFinished() {
//     consoleLog('انتهى الوقت');
//   }

//   String get formattedTime {
//     final minutes = secondsRemaining ~/ 60;
//     final secs = secondsRemaining % 60;
//     return '[$minutes:${secs.toString().padLeft(2, '0')}]';
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     timer?.cancel();
//     otpController.dispose();
//   }

//   void consoleLogOtp() {
//     consoleLog('📥 OTP Entered: ${otpController.text}');
//   }
// }
