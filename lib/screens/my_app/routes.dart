// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<Splash>(name: routeSplash, page: () => const Splash()),
  GetPage<Home>(name: routeHome, page: () => const Home()),
  GetPage<CodeVerificationSheet>(
    name: routeCodeVerificationSheet,
    page: () => const CodeVerificationSheet(),
  ),
];
