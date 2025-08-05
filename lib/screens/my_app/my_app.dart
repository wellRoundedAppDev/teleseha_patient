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
        navigatorObservers: <NavigatorObserver>[
          MyNavigatorObserver(),
        ],
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
