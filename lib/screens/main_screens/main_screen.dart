import '../../general_exports.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (BottomNavController controller) {
        return Scaffold(
          body: controller.pages[controller.selectedIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const CustomBottomNavBar(),
          ),
        );
      },
    );
  }
}
