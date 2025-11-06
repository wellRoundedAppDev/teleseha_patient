// import 'dart:async';

// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../general_exports.dart';

// class FingerPrintController extends GetxController {
//   final LocalAuthentication auth = LocalAuthentication();
//   LocalStorage localStorage = LocalStorage();
//   String? refreshToken;
//   final StartStepsController stepController = Get.find();
//   final MyAppController appController = Get.find();
//   final AuthStorageController authStorage = Get.find();
//   String? myNextStep;

//   Future<void> futureRefreshLogin() async {
//     refreshToken = await localStorage.readFromStorage(storageRefreshToken);

//     await ApiRequest(
//       path: refreshLogin,
//       className: '',
//       formatResponse: true,
//       method: ApiMethods.post,
//       body: <String, String?>{myRefreshToken: refreshToken},
//     ).request(
//       onSuccess: (dynamic data, dynamic response) async {
//         final String? nextStep = response['nextStepEnum']?.toString();

//         await authStorage.saveAuthData(response['data']);

//         myNextStep = nextStep;
//         update();

//         switch (nextStep) {
//           case 'CreateProfile':
//             stepController.currentStep = 3;
//             stepController.update();
//             Get.toNamed(routeSteps);
//             break;
//           case 'SelectProfile':
//             Get.toNamed(routeProfiles);
//             break;
//           case 'OpenHome':
//             Get.toNamed(routeScreen);
//             break;
//           default:
//             Get.offAllNamed(routeLogin);
//         }
//       },
//       // ignore: always_specify_types
//       onError: (error) {
//         authStorage.clearAuthData();
//         Get.toNamed(routeLogin);
//         return null;
//       },
//     );
//   }

//   Future<void> startBiometricAuth() async {
//     final bool canAuthenticateWithBiometrics = await auth.isDeviceSupported();
//     if (!canAuthenticateWithBiometrics) {
//       Fluttertoast.showToast(msg: 'not_support'.tr);
//       return;
//     }

//     final List<BiometricType> availableBiometrics = await auth
//         .getAvailableBiometrics();

//     if (availableBiometrics.isEmpty) {
//       Fluttertoast.showToast(msg: 'piometrics_empty'.tr);
//       return;
//     }

//     try {
//       final bool isAuthenticated = await auth.authenticate(
//         localizedReason: 'please_auth_finger_print'.tr,
//       );
//       if (isAuthenticated) {
//         futureRefreshLogin();
//         // checkUserAndNavigate();
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'error_auth_finger_print'.tr);
//     }
//   }
// }
