import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:client_information/client_information.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../general_exports.dart';

Future<void> launchMailto(String to) async {
  await launchUrl(
    Uri.parse('mailto:$to'),
    mode: LaunchMode.externalApplication,
  );
}

Future<Map<String, dynamic>> getDefaultQueryParams() async {
  final ClientInformation deviceInfo = await ClientInformation.fetch();
  final MyAppController myAppController = Get.find<MyAppController>();
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    keyDeviceModel: deviceInfo.osName,
    keyDeviceName: deviceInfo.deviceName,
    keyDeviceId: deviceInfo.deviceId,
    keyOsVersion: deviceInfo.osVersion,
    keyPlatform: Platform.isAndroid ? platformAndroid : platformIOS,
    keyAppVersion: myAppController.buildNumber,
    'sharedKey': sharedKey,
    'langId': Get.find<MyAppController>().appLocale,
    // keyBidderId: 62, // Open available balance sheet
    // keyBidderId: 83, // Open un available balance sheet (IN_SUFFICIENT_BALANCE)
    // keyBidderId: 101, // Need nafath
    // keyBidderId: 54, // Already registered
    // keyBidderId: 54, // User has wallet
    keyBidderId: myAppController.userData?[keyBidderId],
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

Future<String?> uploadAws(String path) async {
  return await AwsS3.uploadFile(
    accessKey: 'AKIARE4MX7TBSIK3KJ4W',
    secretKey: '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',
    file: File(path),
    bucket: 'safqah',
    region: 'me-south-1',
  );
}
