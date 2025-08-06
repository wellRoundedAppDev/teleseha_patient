// import 'dart:io';

// import 'package:firebase_analytics/firebase_analytics.dart';

// import 'package:package_info_plus/package_info_plus.dart';

// import '../general_exports.dart';

Future<Map<String, dynamic>> getDeviceQueryParams() async {
  Map<String, dynamic> data = <String, dynamic>{};
  data = <String, dynamic>{
    // keyDeviceModel: deviceInfo.osName,
    // keyDeviceName: deviceInfo.deviceName,
    // keyDeviceId: deviceInfo.deviceId,
    // keyOsVersion: deviceInfo.osVersion,
    // keyReleaseNo: packageInfo.buildNumber,
  };
  return data;
}
