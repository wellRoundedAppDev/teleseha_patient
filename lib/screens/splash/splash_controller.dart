import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../../general_exports.dart';

class SplashController extends GetxController {
  MyAppController myAppController = Get.find<MyAppController>();

  @override
  void onReady() {
    super.onReady();

    myAppController.lov(
      onDataFetched: () async {
        // await setBaseUrl();
        // checkAppVersion();
        if (myAppController.userData != null) {
          // if (myAppController.isTokenExpiredOrNull()) {
          // refreshToken();
          // myAppController.setTokenExpiryDate(
          // int.parse(
          // myAppController.getSetOptionValue(keyTokenExpiryHours),
          // ),
          // );
          // } else {
          // isDataLoaded = true;
          // navigate();
          // }
          // if (myAppController.userData != null) {
          // isAccountDelete();
          // }
          // } else {
          // isDataLoaded = true;
        }
        navigate();
      },
    );
  }

  Future<void> navigate() async {
    Get.offAndToNamed(routeHomeBottomBar);
    await FlutterBranchSdk.init(enableLogging: true);
    listenDynamicLinks();
  }

  Future<void> setBaseUrl() async {
    final Map<String, dynamic> deviceQueryParams =
        await getDefaultQueryParams();
    final List<dynamic> labDevices = myAppController.lovData[keyLabDevices];

    for (final dynamic labDevice in labDevices) {
      if (deviceQueryParams[keyDeviceId] == labDevice[keyDeviceId]) {
        baseUrl = labDevice[keyUrl];
        await myAppController.lov();
        if (myAppController.userData != null) {
          // myAppController.getNotificationCounter();
        }
        return;
      }
    }

    baseUrl = myAppController.getSetOptionValue(keyApiBaseUrl);
    // baseUrl = 'https://www.tfaseel.com/apex/lab/';

    if (myAppController.userData != null) {
      // myAppController.getNotificationCounter();
    }
  }
}
