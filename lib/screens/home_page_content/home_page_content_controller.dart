import '../../general_exports.dart';

class HomePageContentController extends GetxController {
  // here get user name about response refresh-login request
  String testNameUserData = 'name_user'.tr;

  // here check response if have last refervations
  bool checkReservations = false;
  int nextReservation = 3;
  int selectedSpecialtyIndex = 0;

  final List<Map<String, dynamic>> specialtiesWithSub = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': iconGeneralSpecialty,
      'title': 'build_specialties'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconPublic, 'title': 'public'.tr},
        <String, String>{
          'icon': iconSubSpecialties1,
          'title': 'sub_specialties_1'.tr,
        },
        <String, String>{
          'icon': iconSubSpecialties2,
          'title': 'sub_specialties_2'.tr,
        },
        <String, String>{
          'icon': iconSubSpecialties3,
          'title': 'sub_specialties_3'.tr,
        },
        <String, String>{
          'icon': iconSubSpecialties4,
          'title': 'sub_specialties_4'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconHeart,
      'title': 'heart'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconHeart, 'title': 'cardiologist'.tr},
        <String, String>{'icon': iconHeart, 'title': 'heart_surgery'.tr},
        <String, String>{
          'icon': iconHeart,
          'title': 'cardiac_rehabilitation'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconTeeth,
      'title': 'teeth'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconTeeth, 'title': 'orthodontics'.tr},
        <String, String>{'icon': iconTeeth, 'title': 'endodontics'.tr},
        <String, String>{'icon': iconTeeth, 'title': 'prosthodontics'.tr},
      ],
    },
    <String, dynamic>{
      'icon': iconBrainAndNerves,
      'title': 'brainAndNerves'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconBrainAndNerves, 'title': 'neurology'.tr},
        <String, String>{
          'icon': iconBrainAndNerves,
          'title': 'neurosurgery'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconDigestiveSystem,
      'title': 'digestiveSystem'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{
          'icon': iconDigestiveSystem,
          'title': 'gastroenterology'.tr,
        },
        <String, String>{'icon': iconDigestiveSystem, 'title': 'hepatology'.tr},
      ],
    },
    <String, dynamic>{
      'icon': iconGynecologyAndObstetrics,
      'title': 'gynecologyAndObstetrics'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{
          'icon': iconGynecologyAndObstetrics,
          'title': 'obstetrics'.tr,
        },
        <String, String>{
          'icon': iconGynecologyAndObstetrics,
          'title': 'gynecology'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconNoseAndEarSurgery,
      'title': 'earNoseAndThroat'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconNoseAndEarSurgery, 'title': 'otology'.tr},
        <String, String>{
          'icon': iconNoseAndEarSurgery,
          'title': 'rhinology'.tr,
        },
        <String, String>{
          'icon': iconNoseAndEarSurgery,
          'title': 'laryngology'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconOrthopedics,
      'title': 'orthopedics'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconOrthopedics, 'title': 'spine'.tr},
        <String, String>{
          'icon': iconOrthopedics,
          'title': 'sports_medicine'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconPsychiatry,
      'title': 'psychiatry'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{
          'icon': iconPsychiatry,
          'title': 'child_psychiatry'.tr,
        },
        <String, String>{
          'icon': iconPsychiatry,
          'title': 'addiction_psychiatry'.tr,
        },
      ],
    },
    <String, dynamic>{
      'icon': iconLungs,
      'title': 'lung'.tr,
      'subSpecialties': <Map<String, String>>[
        <String, String>{'icon': iconLungs, 'title': 'pulmonology'.tr},
        <String, String>{'icon': iconLungs, 'title': 'respiratory_therapy'.tr},
      ],
    },
  ];
  
  void openContentDoctorsAboutSelected(int index) {
    final ChangeParamContentAndNextPage changeParam = Get.find();
    changeParam.goToComponentStatusBar.value = 'Subspecialties';
    selectedSpecialtyIndex = index;
    update();
  }
}
