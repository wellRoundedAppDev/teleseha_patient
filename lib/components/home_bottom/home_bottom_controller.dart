import '../../general_exports.dart';

class BottomNavController extends GetxController {
  int selectedIndexBottomNav = 2;

  final double widthSelected = DEVICE_WIDTH <= 380 ? 75 : 85;
  final double horizontalMargin = DEVICE_WIDTH <= 380 ? 0 : 8;

  final List<String> labels = <String>[
    'home'.tr,
    'doctors'.tr,
    'personal_page'.tr,
    'reports'.tr,
    'settings'.tr,
  ];

  final List<Widget> pages = <Widget>[
    const HomePageContent(),
    const HomePageContent(),
    const HomePageContent(),
    const HomePageContent(),
    const HomePageContent(),
  ];

  // ignore: always_specify_types
  final List icons = <dynamic>[
    iconPersonal,
    iconDoctors,
    iconHome,
    iconReports,
    iconSettings,
  ];

  void changeIndex(int index) {
    selectedIndexBottomNav = index;
    final ChangeParamContentAndNextPage changeParam = Get.find();

    index == 2
        ? changeParam.goToComponentHeader.value = 'HomePage'
        : index == 1
        ? changeParam.goToComponentHeader.value = 'Doctors'
        // ignore: unnecessary_statements
        : '';

    changeParam.update();
    update();
  }
}
