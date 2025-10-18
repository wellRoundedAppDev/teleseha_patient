import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class HomeStatusBar extends StatelessWidget {
  const HomeStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      builder: (HomePageContentController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.035),
          child: Padding(
            padding: EdgeInsets.only(top: DEVICE_HEIGHT * 0.06),
            child: Column(
              children: <Widget>[
                const LogoHome(),
                SizedBox(height: DEVICE_HEIGHT * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomText(
                      text:
                          '${'say_welcome'.tr} ${controller.testNameUserData}!',
                      fontSize: 20,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorWhiteSelectedType),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(routeNotifications);
                          },
                          child: SvgPicture.asset(iconNotification),
                        ),
                        Positioned(
                          top: DEVICE_WIDTH * -0.025,
                          right: DEVICE_HEIGHT * -0.002,
                          child: Container(
                            width: DEVICE_WIDTH * 0.03,
                            height: DEVICE_HEIGHT * 0.03,
                            decoration: BoxDecoration(
                              color: const Color(
                                AppColors.colorPointerNotification,
                              ),
                              shape: BoxShape.circle,
                              border: BoxBorder.all(
                                color: const Color(
                                  AppColors.colorPointerborder,
                                ),
                                width: DEVICE_WIDTH * 0.004,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.027),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.04,
                    vertical: DEVICE_HEIGHT * 0.012,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(AppColors.colorReception),
                    borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.024),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFDADADA).withValues(alpha: 0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: StyleBtnHeader(
                          textBtn: 'start_now'.tr,
                          size: 12,
                          width: 0.24,
                          height: 0.05,
                          onPressed: () {
                            final ChangeParamContentAndNextPage change =
                                Get.find();
                            change.goToComponentHeader.value = 'gemini';
                            change.knowNextPage.value =
                                'Comping from home going to reception';
                            change.update();
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    iconReception,
                                    width: DEVICE_WIDTH * 0.021,
                                    height: DEVICE_HEIGHT * 0.021,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: DEVICE_HEIGHT * 0.005),
                                  Container(
                                    margin: const EdgeInsets.only(top: 1),
                                    child: CustomText(
                                      text: 'medical_reception'.tr,
                                      fontSize: 13,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.008),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: 'dont_know_subilshate'.tr,
                                fontSize: 12,
                                color: const Color(AppColors.colorTextSkep),
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.005),
                              CustomText(
                                text: 'selected_subilshate'.tr,
                                fontSize: 12,
                                color: const Color(AppColors.colorTextSkep),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
