import 'dart:async';
import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  String? versionName;
  String? buildNumber;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;
  dynamic response;
  String otp = '';
  AuthType authType = AuthType.signIn;
  int seconds = 120;
  Timer? otpTimer;
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyEnNameController = TextEditingController();
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
  }

  void resendCode() {
    if (seconds == 0) {
      seconds = 120;
      startTimer();
      if (authType == AuthType.signIn) {
        // preSignIn(shouldOpenCodeVerificationSheet: false);
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
}
