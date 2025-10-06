// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../general_exports.dart';
import '../../language/translation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(AppColors.colorBackgroundScreen),
        ),
        locale: const Locale('ar'),
        supportedLocales: <Locale>[const Locale('ar')],
        // ignore: always_specify_types
        localizationsDelegates: <LocalizationsDelegate>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: Translation(),
        debugShowCheckedModeBanner: false,        
        initialRoute: routeFingerPrint,
        // initialRoute: routeScreen,
        getPages: appRoutes,
        builder: (BuildContext context, Widget? child) {
          return Stack(children: <Widget>[FlutterSmartDialog(child: child)]);
        },
      ),
    );
  }
}
