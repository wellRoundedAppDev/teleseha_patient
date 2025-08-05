import '../../general_exports.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBottomBarController>(
      init: HomeBottomBarController(),
      builder: (HomeBottomBarController controller) {
        return PopScope(
          canPop: controller.canPop,
          onPopInvoked: (bool isPop) async {
            controller.onWillPop();
          },
          child: Scaffold(
            backgroundColor: const Color(AppColors.grey),
            body: controller.pages[controller.bottomBarIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black38, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(DEVICE_WIDTH * 0.02),
                  topRight: Radius.circular(DEVICE_WIDTH * 0.02),
                ),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    ...controller.bottomBar.map((dynamic item) {
                      return BottomNavigationBarItem(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              visible:
                                  controller.bottomBar.indexOf(item) == 2 &&
                                  Get.find<MyAppController>().userData !=
                                      null &&
                                  Get.find<MyAppController>()
                                          .userData[storeLocationPermission] ==
                                      1,
                              child: Image.asset(
                                gifAnimatedIcon,
                                width: DEVICE_HEIGHT * 0.01,
                                height: DEVICE_HEIGHT * 0.01,
                              ),
                            ),
                          ],
                        ),
                        label: item[name],
                      );
                    }),
                  ],
                  selectedLabelStyle: const TextStyle(fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.bottomBarIndex,
                  backgroundColor: const Color(AppColors.grey),
                  selectedItemColor: const Color(AppColors.grey),
                  unselectedItemColor: const Color(AppColors.grey),
                  onTap: (int index) {
                    if (index == 2 || index == 3) {
                      if (Get.find<MyAppController>().userData != null) {
                        controller.onItemTapped(index);
                      } else {
                        Get.find<MyAppController>().openSignInSheet(
                          action: () {
                            controller.onItemTapped(index);
                          },
                        );
                      }
                    } else {
                      controller.onItemTapped(index);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
