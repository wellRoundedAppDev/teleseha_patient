import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'general_exports.dart';

Future<void> main() async {
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.requestPermission();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Permission.notification.isDenied.then((bool value) {
    if (value) {
      Permission.notification.request();
    }
  });

  Get.put(AuthStorageController());
  Get.put(LoginController());
  Get.put(StartStepsController());
  Get.put(MyAppController());
  // Get.put(BookingsController());


  Get.put(ChangeParamContentAndNextPage(), permanent: true);

  Get.put(VideoCallController(), permanent: true);

  Get.put(ListPresciption(), permanent: true);

  consoleLogPretty(baseUrl, key: 'baseUrl');
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
