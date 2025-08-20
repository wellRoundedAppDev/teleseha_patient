import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;

  void onSignOut() {
    userData = null;
    update();
  }

  void onUserAuthenticated(dynamic userDataValue) {
    userData = userDataValue;
    consoleLog('onUserAuthenticated$userData');
    update();
  }
}
