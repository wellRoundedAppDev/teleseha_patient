import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../general_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(AppColors.colorBackgroundScreen),
        ),
        locale: Locale('ar'),
        supportedLocales: [Locale('ar')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: Translation(),
        debugShowCheckedModeBanner: false,
        // initialRoute: routeSplash,
        initialRoute: routeAuth,
        getPages: appRoutes,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: <Widget>[
              FlutterSmartDialog(child: child),
            ],
          );
        },
      ),
    );
  }
}
