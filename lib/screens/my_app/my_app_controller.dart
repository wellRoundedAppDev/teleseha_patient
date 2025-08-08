import 'dart:async';
import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  String? versionName;
  String? buildNumber;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;
  dynamic response;
  AuthType authType = AuthType.signIn;
  Timer? otpTimer;
  bool isCompanySelected = true;
  Function()? successAction;

  @override
  Future<void> onInit() async {
    super.onInit();
    consoleLog(userData, key: 'userData');
  }

  void onUserAuthenticated(dynamic userDataValue) {
    userData = userDataValue;
    consoleLog('onUserAuthenticated$userData');
    update();
  }

  void onSignOut() {
    userData = null;
    update();
  }

  void openSignUpSheet({Function()? action}) {
    authType = AuthType.signUp;
    if (Get.isBottomSheetOpen!) {
      Get.back();
    }
  }
}
