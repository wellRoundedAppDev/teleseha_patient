import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;

  // check user if user success open otp else open reigster
  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   userData = await localStorage.getFromStorage(key: storeLocationPermission);

  //   consoleLog(userData, key: 'userData');

  //   final String? languageCode = await localStorage.getFromStorage(
  //     key: storeLocationPermission,
  //   );
  // }

  void onSignOut() {
    userData = null;
    update();
  }

  void onUserAuthenticated(dynamic userDataValue) {
    // localStorage.saveToStorage(key: storeUser, value: userDataValue);
    userData = userDataValue;
    consoleLog('onUserAuthenticated$userData');
    update();
  }
}
