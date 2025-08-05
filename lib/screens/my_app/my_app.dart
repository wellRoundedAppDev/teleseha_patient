import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../general_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        locale: Locale(Get.find<MyAppController>().appLocale),
        navigatorObservers: <NavigatorObserver>[
          MyNavigatorObserver(),
        ],
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(AppColors.grey),
          ),
          splashColor: Colors.transparent,
          bottomSheetTheme: const BottomSheetThemeData(
            elevation: 0.0,
          ),
          fontFamily: getFont(),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(AppColors.grey),
            selectionHandleColor: Color(AppColors.grey),
          ),
          useMaterial3: true,
          primaryColor: const Color(AppColors.grey),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: const Color(AppColors.grey),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.017),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
              ),
            ),
          ),
          textTheme: TextTheme(
            headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: getFont(),
            ),
            bodySmall: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontFamily: getFont(),
            ),
            bodyMedium: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: getFont(),
            ),
            bodyLarge: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: getFont(),
            ),
          ),
        ),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: routeSplash,
        getPages: appRoutes,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: <Widget>[
              FlutterSmartDialog(child: child),
              GetBuilder<MyAppController>(
                builder: (MyAppController controller) {
                  return AnimatedPositioned(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    top: DEVICE_HEIGHT *
                        ((!controller.isInternetConnect &&
                                controller.shouldShowNoInternetDialog)
                            ? 0.08
                            : 0.0),
                    left: DEVICE_WIDTH * 0.05,
                    right: DEVICE_WIDTH * 0.05,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      height: (!controller.isInternetConnect &&
                              controller.shouldShowNoInternetDialog)
                          ? DEVICE_HEIGHT * 0.2
                          : 0.0,
                      child: const NoInternetConnection(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyNavigatorObserver extends GetObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (Platform.isAndroid) {
      dismissLoading();
    }
  }
}
