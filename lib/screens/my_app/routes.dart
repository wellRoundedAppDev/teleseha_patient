// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  // GetPage<Splash>(name: routeSplash, page: () => Splash()),
  // GetPage<Home>(name: routeHome, page: () => Home()),
  GetPage<Auth>(name: routeAuth, page: () => Auth()),
];
