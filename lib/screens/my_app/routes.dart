// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<Auth>(name: routeAuth, page: () => Auth()),
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<Success>(name: routeSuccess, page: () => Success()),
  GetPage<DiagnosisRecipient>(
    name: routeDiagnosis,
    page: () => DiagnosisRecipient(),
  ),
];
