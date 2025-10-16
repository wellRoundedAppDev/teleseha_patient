import 'dart:convert';

import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  String? refreshToken;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;  

  final StartStepsController stepController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // futureRefreshLogin();
  }

  void onSignOut() {
    userData = null;
    update();
  }

  void onUserAuthenticated(dynamic userDataValue) {
    userData = userDataValue;
    update();
  }
}
