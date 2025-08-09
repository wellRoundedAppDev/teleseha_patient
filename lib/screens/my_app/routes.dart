// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<FootPrint>(name: routeAuth, page: () => FootPrint()),
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeSuccess,
    page: () => CreateAccountSuccess(),
  ),
  GetPage<DiagnosisRecipient>(
    name: routeDiagnosis,
    page: () => DiagnosisRecipient(),
  ),
  GetPage<TypeChildren>(name: routeTypeChildren, page: () => TypeChildren()),
];
