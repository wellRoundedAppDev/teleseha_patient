import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  String? refreshToken;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;

  @override
  void onInit() {
    super.onInit();
    _loadRefreshToken();
  }

  Future<void> _loadRefreshToken() async {
    refreshToken = await localStorage.readFromStorage('refreshToken');
    consoleLog('Loaded refreshToken: $refreshToken');
    update();
  }

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
