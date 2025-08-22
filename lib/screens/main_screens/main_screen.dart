import '../../general_exports.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (BottomNavController controller) {
        return Scaffold(
          body: controller.pages[controller.selectedIndex],
          bottomNavigationBar: CustomBottomNavBar(),
        );
      },
    );
  }
}
