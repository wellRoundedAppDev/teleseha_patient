import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';
import 'index.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (NotificationsController controller) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.027),
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: Get.back,
                  child: SvgPicture.asset(
                    iconBack,
                    width: 24,
                    height: 24,
                    // ignore: deprecated_member_use
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: 'notifications'.tr,
                      fontSize: 18,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorLineAndText),
                    ),
                    SizedBox(width: DEVICE_WIDTH * 0.02),
                    SvgPicture.asset(
                      iconNotification,
                      width: 24,
                      height: 26,
                      // ignore: deprecated_member_use
                      color: const Color(AppColors.colorLineAndText),
                    ),
                  ],
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
                SizedBox(
                  height: DEVICE_HEIGHT * 0.7,
                  child: ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0
                          ? Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: DEVICE_HEIGHT * 0.03,
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      211,
                                      184,
                                      217,
                                      241,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: const Color(
                                          0xFFD8DADC,
                                        ).withValues(alpha: 0.4),
                                        blurRadius: 6,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            iconCalendar,
                                            width: DEVICE_WIDTH * 0.025,
                                            height: DEVICE_HEIGHT * 0.025,
                                          ),
                                          SizedBox(width: DEVICE_WIDTH * 0.02),
                                          CustomText(
                                            text: controller
                                                .notifications[index]['title'],
                                            fontSize: 13,
                                            type: CustomTextType.title,
                                            color: const Color(
                                              AppColors.colorLineAndText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            iconNotification,
                                            width: DEVICE_WIDTH * 0.025,
                                            height: DEVICE_HEIGHT * 0.025,
                                            // ignore: deprecated_member_use
                                            color: const Color(
                                              AppColors.colorTitleDoppler,
                                            ),
                                          ),
                                          SizedBox(width: DEVICE_WIDTH * 0.03),
                                          SizedBox(
                                            width: DEVICE_WIDTH * 0.57,
                                            child: CustomText(
                                              text: 'take_care'.tr,
                                              fontSize: 10,
                                              type: CustomTextType.title,
                                              color: const Color(
                                                AppColors.colorTitleDoppler,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          CustomText(
                                            text: 'after_hour'.tr,
                                            fontSize: 8,
                                            type: CustomTextType.title,
                                            color: const Color(
                                              AppColors.colorEndChat,
                                            ),
                                          ),
                                          SizedBox(width: DEVICE_WIDTH * 0.01),
                                          SvgPicture.asset(
                                            iconTime,
                                            width: DEVICE_WIDTH * 0.022,
                                            height: DEVICE_HEIGHT * 0.022,
                                            // ignore: deprecated_member_use
                                            color: const Color(
                                              AppColors.colorEndChat,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: StyleBtnHeader(
                                    textBtn: 'join_now'.tr,
                                    size: 10,
                                    width: 0.19,
                                    height: 0.06,
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: DEVICE_WIDTH * 0.01,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                        163,
                                        52,
                                        161,
                                        219,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                bottom: DEVICE_HEIGHT * 0.03,
                              ),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(
                                  AppColors.colorWhiteSelectedType,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: const Color(
                                      0xFFD8DADC,
                                    ).withValues(alpha: 0.4),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: DEVICE_WIDTH * 0.025,
                                                height: DEVICE_HEIGHT * 0.015,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: DEVICE_WIDTH * 0.02,
                                              ),
                                              CustomText(
                                                text: controller
                                                    .notifications[index]['title'],
                                                fontSize: 14,
                                                type: CustomTextType.title,
                                                color: const Color(
                                                  AppColors.colorLineAndText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: DEVICE_HEIGHT * 0.01,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const SizedBox(),
                                              SizedBox(
                                                width: DEVICE_WIDTH * 0.03,
                                              ),
                                              SizedBox(
                                                width: DEVICE_WIDTH * 0.57,
                                                child: CustomText(
                                                  text: controller
                                                      .notifications[index]['text'],
                                                  fontSize: 10,
                                                  type: CustomTextType.title,
                                                  color: const Color(
                                                    AppColors.colorTitleDoppler,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        controller.notifications[index]['icon'],
                                        width: DEVICE_WIDTH * 0.05,
                                        height: DEVICE_HEIGHT * 0.05,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.022),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: DEVICE_HEIGHT * 0.02,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        StyleBtnHeader(
                                          textBtn: controller
                                              .notifications[index]['text_btn'],
                                          size: 10,
                                          width: 0.25,
                                          height: 0.05,
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: DEVICE_WIDTH * 0.01,
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                  163,
                                                  52,
                                                  161,
                                                  219,
                                                ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            CustomText(
                                              text: controller
                                                  .notifications[index]['time'],
                                              fontSize: 8,
                                              type: CustomTextType.title,
                                              color: const Color(
                                                AppColors.colorEndChat,
                                              ),
                                            ),
                                            SizedBox(
                                              width: DEVICE_WIDTH * 0.01,
                                            ),
                                            SvgPicture.asset(
                                              iconTime,
                                              width: DEVICE_WIDTH * 0.022,
                                              height: DEVICE_HEIGHT * 0.021,
                                              // ignore: deprecated_member_use
                                              color: const Color(
                                                AppColors.colorEndChat,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
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
