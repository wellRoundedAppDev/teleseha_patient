import '../../general_exports.dart';

class HomeBottomBarController extends GetxController {
  List<Widget> pages = <Widget>[
    const Home(),
  ];
  List<dynamic> bottomBar = <dynamic>[];
  int bottomBarIndex = 0;
  DateTime? lastBackPressed;
  bool canPop = false;

  void onItemTapped(int index) {
    bottomBarIndex = index;
    update();
  }

  Future<bool> onWillPop() async {
    final DateTime now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      // If the back button is pressed again within 2 seconds, exit
      lastBackPressed = now;
      showToast(message: 'are_you_sure_you_want_to_exist'.tr);

      canPop = false;
      update();
      return Future<bool>.value(false); // Don't exit the app yet
    }
    canPop = true;
    update();
    return Future<bool>.value(true);
  }
}
