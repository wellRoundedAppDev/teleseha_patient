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
    _loadRefreshToken();
  }

  Future<void> _loadRefreshToken() async {
    refreshToken = await localStorage.readFromStorage(storageRefreshToken);
    if (refreshToken != null) {
      // await localStorage.removeFromStorage(key: storageRefreshToken);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(routeSteps);
        stepController.currentStep = 3;
      });
    }
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
