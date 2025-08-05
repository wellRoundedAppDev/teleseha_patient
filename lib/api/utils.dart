// import 'dart:io';

import 'package:client_information/client_information.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../general_exports.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// import '../general_exports.dart';

Future<Map<String, dynamic>> getDeviceQueryParams() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final ClientInformation deviceInfo = await ClientInformation.fetch();
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    name: deviceInfo.osName,
    name: deviceInfo.deviceName,
    name: deviceInfo.deviceId,
    name: deviceInfo.osVersion,
    name: packageInfo.buildNumber,
    // keyDeviceModel: deviceInfo.osName,
    // keyDeviceName: deviceInfo.deviceName,
    // keyDeviceId: deviceInfo.deviceId,
    // keyOsVersion: deviceInfo.osVersion,
    // keyReleaseNo: packageInfo.buildNumber,
  };
  return data;
}
