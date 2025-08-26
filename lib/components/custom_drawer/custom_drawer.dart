import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({required this.onClose, super.key});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      builder: (HomePageContentController controller) {
        return ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.05),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DEVICE_WIDTH * 0.04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CustomText(
                              text: 'filter'.tr,
                              fontSize: 14,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorFilter),
                            ),
                            SizedBox(width: DEVICE_WIDTH * 0.015),
                            CustomText(
                              text: 'doctor_filter'.tr,
                              fontSize: 14,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorReset),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            iconClose,
                            width: DEVICE_WIDTH * 0.014,
                            height: DEVICE_HEIGHT * 0.014,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.06),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.04,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomText(
                              text: 'specialties'.tr,
                              fontSize: 12,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorFilter),
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    if (controller.selectedIndex == 0) {
                                      return;
                                    } else {
                                      controller.scrollController.animateTo(
                                        controller.scrollController.offset -
                                            100,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                      controller.selectedIndex--;
                                      controller.update();
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    iconCarouselRight,
                                    width: DEVICE_WIDTH * 0.025,
                                    height: DEVICE_HEIGHT * 0.025,
                                    color: controller.selectedIndex == 0
                                        ? const Color(AppColors.colorBlack)
                                        : const Color(
                                            AppColors.colorLineAndText,
                                          ),
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.selectedIndex <
                                        controller.specialtiesWithSub.length -
                                            1) {
                                      controller.scrollController.animateTo(
                                        controller.scrollController.offset +
                                            100,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                      controller.selectedIndex++;
                                      controller.update();
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    iconCarouselLeft,
                                    width: DEVICE_WIDTH * 0.025,
                                    height: DEVICE_HEIGHT * 0.025,
                                    color:
                                        controller.selectedIndex <
                                            controller
                                                    .specialtiesWithSub
                                                    .length -
                                                1
                                        ? const Color(
                                            AppColors.colorLineAndText,
                                          )
                                        : const Color(AppColors.colorBlack),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.02),
                      SizedBox(
                        width: DEVICE_WIDTH,
                        height: DEVICE_HEIGHT * 0.04,
                        child: SizedBox(
                          height: 48,
                          child: ListView.builder(
                            controller: controller.scrollController,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: controller.specialtiesWithSub.length,
                            itemBuilder: (BuildContext context, int index) {
                              final bool isSelected =
                                  controller.selectedIndex == index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // create request filter specialties
                                    controller.selectedIndex = index;
                                    controller.update();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(
                                              AppColors.colorLineAndText,
                                            )
                                          : const Color.fromARGB(
                                              205,
                                              187,
                                              222,
                                              251,
                                            ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: CustomText(
                                      text: controller
                                          .specialtiesWithSub[index]['title'],
                                      fontSize: 12,
                                      type: CustomTextType.button,
                                      color: isSelected
                                          ? const Color(
                                              AppColors.colorWhiteSelectedType,
                                            )
                                          : const Color(
                                              AppColors.colorLineAndText,
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.032),
                      Container(
                        height: DEVICE_HEIGHT * 0.001,
                        width: DEVICE_WIDTH,
                        color: const Color(AppColors.colorFilterLine),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.017),
                      Container(
                        width: DEVICE_WIDTH,
                        padding: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomText(
                              text: 'academic_degree'.tr,
                              fontSize: 14,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorFilter),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.019),
                            Wrap(
                              spacing: 9,
                              runSpacing: 11,
                              children: List.generate(
                                controller.academicDegree.length,
                                (int index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: DEVICE_WIDTH * 0.32,
                                    height: DEVICE_HEIGHT * 0.044,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        133,
                                        195,
                                        218,
                                        235,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: CustomText(
                                      text: controller
                                          .academicDegree[index]['title'],
                                      type: CustomTextType.title,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
