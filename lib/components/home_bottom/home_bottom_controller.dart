import '../../general_exports.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 2;
  
  final double widthSelected = DEVICE_WIDTH <= 380 ? 75 : 95;
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
    const Doctors(),
    const HomePageContent(),
    const Doctors(),
    const HomePageContent(),
  ];

  final List icons = <dynamic>[
    iconPersonal,
    iconDoctors,
    iconHome,
    iconReports,
    iconSettings,
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
