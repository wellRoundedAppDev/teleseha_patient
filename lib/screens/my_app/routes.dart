// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<PatternLockPage>(
    name: routePatternLock,
    page: () => const PatternLockPage(),
  ),
  GetPage<StartSteps>(name: routeSteps, page: () => const StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeCreateAccountSuccess,
    page: () => const CreateAccountSuccess(),
  ),
  GetPage<DiagnosisRecipient>(
    name: routeDiagnosis,
    page: () => const DiagnosisRecipient(),
  ),
  GetPage<TypeChildren>(
    name: routeSelectTypeChildren,
    page: () => const TypeChildren(),
  ),
  GetPage<MedicalHistory>(
    name: routeFormDiagnosis,
    page: () => const MedicalHistory(),
  ),
  GetPage<Home>(name: routeHome, page: () => const Home()),
];
