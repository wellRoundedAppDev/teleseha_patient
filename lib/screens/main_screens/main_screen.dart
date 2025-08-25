import '../../general_exports.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  ChangeParamContentAndNextPage changeParam = Get.put(ChangeParamContentAndNextPage());

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (BottomNavController controller) {
        return Scaffold(
          body: controller.pages[controller.selectedIndex],
          bottomNavigationBar: Obx(() {
            return change.goToComponentStatusBar == 'HomePage' ||
                    change.goToComponentStatusBar == 'Doctors'||
                    change.goToComponentStatusBar == 'Subspecialties'
                ? Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: controller.horizontalMargin,
                    ),
                    child: const CustomBottomNavBar(),
                  )
                : const SizedBox();
          }),
        );
      },
    );
  }
}
