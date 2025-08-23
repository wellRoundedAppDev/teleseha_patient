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
          child: Container(
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            iconUser,
                            width: DEVICE_WIDTH * 0.034,
                            height: DEVICE_HEIGHT * 0.034,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.015),
                          CustomText(
                            text:
                                '${'say_welcome'.tr} ${controller.testNameUserData}!',
                            fontSize: 22,
                            type: CustomTextType.title,
                            color: const Color(
                              AppColors.colorWhiteSelectedType,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        SvgPicture.asset(iconNotification),
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
                    vertical: DEVICE_HEIGHT * 0.01,
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
                  child: Column(
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
                                  fontSize: 15,
                                  type: CustomTextType.title,
                                  color: const Color(
                                    AppColors.colorLineAndText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          StyleBtnHeader(                            
                            textBtn: 'start_now'.tr,
                            onPressed: () {
                              Get.toNamed(routeSymptoms);
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomText(
                            text: 'dont_know_subilshate'.tr,
                            fontSize: 13,
                            color: const Color(AppColors.colorTextSkep),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.005),
                          CustomText(
                            text: 'selected_subilshate'.tr,
                            fontSize: 13,
                            color: const Color(AppColors.colorTextSkep),
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
