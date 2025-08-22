// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<Login>(name: routeLogin, page: () => const Login()),
  GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<profiles>(name: routeProfiles, page: () => const profiles()),
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeCreateAccountSuccess,
    page: () => const CreateAccountSuccess(),
  ),
  GetPage<MedicalHistory>(
    name: routeFormDiagnosis,
    page: () => const MedicalHistory(),
  ),
  GetPage<MainScreen>(name: routeScreen, page: () => const MainScreen()),
  GetPage<Symptoms>(name: routeSymptoms, page: () => const Symptoms()),
];
