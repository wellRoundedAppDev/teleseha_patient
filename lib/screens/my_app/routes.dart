// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<Login>(name: routeLogin, page: () => const Login()),
  GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<LoginAboutHow>(
    name: routeLoginAboutHow,
    page: () => const LoginAboutHow(),
  ),
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeCreateAccountSuccess,
    page: () => const CreateAccountSuccess(),
  ),
  GetPage<MedicalHistory>(
    name: routeFormDiagnosis,
    page: () => const MedicalHistory(),
  ),
  GetPage<Home>(name: routeHome, page: () => const Home()),
];
