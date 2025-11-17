// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<Login>(name: routeLogin, page: () => const Login()),
  // GetPage<FingerPrint>(name: routeFingerPrint, page: () => const FingerPrint()),
  GetPage<Profiles>(name: routeProfiles, page: () => const Profiles()),
  GetPage<StartSteps>(name: routeSteps, page: () => StartSteps()),
  GetPage<CreateAccountSuccess>(
    name: routeCreateAccountSuccess,
    page: () => const CreateAccountSuccess(),
  ),
  GetPage<MedicalHistory>(
    name: routeFormDiagnosis,
    page: () => const MedicalHistory(),
  ),
  GetPage<MainScreen>(name: routeScreen, page: () => MainScreen()),
  // GetPage<VideoCall>(name: routeVideoCall, page: () => VideoCall()),
  GetPage<Notifications>(
    name: routeNotifications,
    page: () => const Notifications(),
  ),
  GetPage<DetailsAboutYou>(name: details, page: () => const DetailsAboutYou()),
  GetPage<Security>(name: routeSecurity, page: () => const Security()),
  GetPage<TechnicalSupport>(
    name: routeTechnicalSupport,
    page: () => const TechnicalSupport(),
  ),
  GetPage<PrivacyPolicy>(
    name: routePrivacyPolicy,
    page: () => const PrivacyPolicy(),
  ),
  GetPage<TermsAndConditions>(
    name: routeTermsAndConditions,
    page: () => const TermsAndConditions(),
  ),
  GetPage<Policiesandprocedures>(
    name: routepoliciesAndProcedures,
    page: () => const Policiesandprocedures(),
  ),
];
