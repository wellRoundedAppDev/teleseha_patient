// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeCreateAccountSuccess,
    page: () => CreateAccountSuccess(),
  ),
  GetPage<DiagnosisRecipient>(
    name: routeDiagnosis,
    page: () => DiagnosisRecipient(),
  ),
  GetPage<TypeChildren>(
    name: routeSelectTypeChildren,
    page: () => TypeChildren(),
  ),
  GetPage<MedicalHistory>(
    name: routeFormDiagnosis,
    page: () => MedicalHistory(),
  ),
  // GetPage<FingerPrint>(name: routeFingerPrint, page: () => FingerPrint()),
];
