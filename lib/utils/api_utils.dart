import 'package:client_information/client_information.dart';

import '../../general_exports.dart';

Future<Map<String, dynamic>> getDefaultQueryParams() async {
  final ClientInformation deviceInfo = await ClientInformation.fetch();
  final MyAppController myAppController = Get.find<MyAppController>();
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    name: deviceInfo.osName,
    name: deviceInfo.deviceName,
    name: deviceInfo.deviceId,
    name: deviceInfo.osVersion,
    name: myAppController.buildNumber,
    // keyDeviceModel: deviceInfo.osName,
    // keyDeviceName: deviceInfo.deviceName,
    // keyDeviceId: deviceInfo.deviceId,
    // keyOsVersion: deviceInfo.osVersion,
    // keyPlatform: Platform.isAndroid ? platformAndroid : platformIOS,
    // keyAppVersion: myAppController.buildNumber,
    'sharedKey': sharedKey,
    // keyBidderId: 62, // Open available balance sheet
    // keyBidderId: 83, // Open un available balance sheet (IN_SUFFICIENT_BALANCE)
    // keyBidderId: 101, // Need nafath
    // keyBidderId: 54, // Already registered
    // keyBidderId: 54, // User has wallet
    name: myAppController.userData?[name],
  };
  if (myAppController.userData != null) {
    // data[keyStudentId] = myAppController.userData[keyStudentId];
    // data[keyStudentId] = myAppController.userData[keyStudentIdSmall] ??
    //     myAppController.userData[keyStudentId];
  }
  // if (currentLocationData != null) {
  //   // We need to make sure that getCurrentLocation is called before we get here
  //   data[keyLocLat] = currentLocationData?.latitude.toString();
  //   data[keyLocLong] = currentLocationData?.longitude.toString();
  // }
  return data;
}

void openWebview(String key, String title) {
  // final MyAppController myAppController = Get.find<MyAppController>();
  // final AppLanguageController appLanguageController =
  //     Get.find<AppLanguageController>();

  // Get.toNamed(
  //   routeWebviewScreen,
  //   arguments: <String, String>{
  //     argUrl:
  //         '${myAppController.getSetOptionValue(key)}?P_LANG=${appLanguageController.appLocale}',
  //     keyTitle: title,
  //   },
  // );
}
