import '../../general_exports.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ChangeParamContentAndNextPage changeParam = Get.put(
    ChangeParamContentAndNextPage(),
  );

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.put(
      BottomNavController(),
    );
    final HomePageContentController homeController = Get.put(
      HomePageContentController(),
    );

    return Obx(() {
      return Stack(
        children: <Widget>[
          Scaffold(
            resizeToAvoidBottomInset: true,
            body: bottomNavController
                .pages[bottomNavController.selectedIndexBottomNav.value],
            bottomNavigationBar:
                changeParam.goToComponentHeader.value == 'HomePage' ||
                    changeParam.goToComponentHeader.value == 'RecentBookings' ||
                    changeParam.goToComponentHeader.value == 'Doctors' ||
                    changeParam.goToComponentHeader.value == 'Subspecialty'
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // margin: EdgeInsets.symmetric(
                    //   horizontal: bottomNavController.horizontalMargin,
                    // ),
                    child: const CustomBottomNavBar(),
                  )
                : const SizedBox(),
          ),

          Obx(() {
            if (!homeController.isDrawerOpen.value) {
              return const SizedBox();
            }
            return Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  homeController.isDrawerOpen.value = false;
                },
                child: Container(color: Colors.black54),
              ),
            );
          }),

          Obx(() {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              right: homeController.isDrawerOpen.value
                  ? 0
                  : -DEVICE_WIDTH * 0.76,
              bottom: 0,
              child: Material(
                elevation: 16,
                child: SizedBox(
                  width: DEVICE_WIDTH * 0.76,
                  child: SizedBox(
                    height: DEVICE_HEIGHT,
                    child: CustomDrawer(
                      onClose: () {
                        homeController.isDrawerOpen.value = false;
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      );
    });
  }
}
