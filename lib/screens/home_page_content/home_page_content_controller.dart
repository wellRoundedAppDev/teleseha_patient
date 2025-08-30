import '../../general_exports.dart';

class HomePageContentController extends GetxController {
  // here get user name about response refresh-login request
  String testNameUserData = 'name_user'.tr;

  // here check response if have last reservations
  bool checkReservations = true;
  int nextReservation = 3;
  int selectedSpecialtyIndex = 0;
  int selectedIndex = 2;
  int selectedacademicDegree = 1;
  int selectedAppointmentsAvailable = 1;
  final ScrollController scrollController = ScrollController();
  RxBool isDrawerOpen = false.obs;
  RxDouble currentSliderValue = 100.0.obs;

  final List<Map<String, dynamic>> specialtiesWithSub = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': iconGeneralSpecialty,
      'title': 'build_specialties'.tr,
    },
    <String, dynamic>{
      'icon': iconHeart,
      'title': 'heart'.tr,
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
        <String, String>{'icon': iconDigestiveSystem, 'title': 'hematology'.tr},
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
    if (index == 0) {
      final BottomNavController homeBottomController = Get.find();
      homeBottomController.selectedIndexBottomNav = 1;
      changeParam.goToComponentHeader.value = 'Doctors';
      selectedSpecialtyIndex = index;
      homeBottomController.update();
      update();
    } else {
      changeParam.goToComponentHeader.value = 'Subspecialty';
      selectedSpecialtyIndex = index;
      update();
    }
  }

  final List<Map<String, dynamic>> academicDegree = <Map<String, dynamic>>[
    <String, dynamic>{'title': 'general_practitioner'.tr},
    <String, dynamic>{'title': 'specialist'.tr},
    <String, dynamic>{'title': 'consultative'.tr},
    <String, dynamic>{'title': 'teacher'.tr},
    <String, dynamic>{'title': 'mr'.tr},
  ];

  final List<Map<String, dynamic>> appointmentsAvailable =
      <Map<String, dynamic>>[
        <String, dynamic>{'title': 'today'.tr},
        <String, dynamic>{'title': 'tomorrow'.tr},
        <String, dynamic>{'title': 'this_week'.tr},
      ];
}
