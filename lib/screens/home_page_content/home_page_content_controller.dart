import '../../general_exports.dart';

class HomePageContentController extends GetxController {
  // here get user name about response refresh-login request
  String testNameUserData = 'name_user'.tr;

  // here check response if have last refervations
  bool checkReservations = false;
  int nextReservation = 3;
  int selectedIndexBottomNavigationBar = 0;

  final List<Map<String, dynamic>> specialties = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': iconGeneralSpecialty,
      'title': 'build_specialties'.tr,
    },
    <String, dynamic>{'icon': iconHeart, 'title': 'heart'.tr},
    <String, dynamic>{'icon': iconTeeth, 'title': 'teeth'.tr},
    <String, dynamic>{'icon': iconBrainAndNerves, 'title': 'brainAndNerves'.tr},
    <String, dynamic>{
      'icon': iconDigestiveSystem,
      'title': 'digestiveSystem'.tr,
    },
    <String, dynamic>{
      'icon': iconGynecologyAndObstetrics,
      'title': 'gynecologyAndObstetrics'.tr,
    },
    <String, dynamic>{
      'icon': iconNoseAndEarSurgery,
      'title': 'earNoseAndThroat'.tr,
    },
    <String, dynamic>{'icon': iconOrthopedics, 'title': 'orthopedics'.tr},
    <String, dynamic>{'icon': iconPsychiatry, 'title': 'psychiatry'.tr},
    <String, dynamic>{'icon': iconLungs, 'title': 'lung'.tr},
  ];
  
  void openContentDoctorsAboutSelected() {
    //   final BottomNavController findBottomController = Get.find();

    //   final DoctorsController doctorsController = Get.find();
    //   doctorsController.passedIndex = index;

    final ChangeParamContentAndNextPage changeParam = Get.find();
    changeParam.goToComponentStatusBar.value = 'Subspecialties';
    update();

    //   if (index == 0) {
    //     doctorsController.selectedGeneralOrSpecializedMajor = true;
    //     changeParam.goToComponentStatusBar.value = 'Symptoms';
    //   } else {
    //     doctorsController.selectedGeneralOrSpecializedMajor = false;
    //   }

    //   changeParam.update();
    //   doctorsController.update();
    //   findBottomController.update();
  }
}
