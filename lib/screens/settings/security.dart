import 'package:flutter_svg/svg.dart';

import '../../components/containerSettings.dart';
import '../../general_exports.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.027),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: DEVICE_WIDTH,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      iconBack,
                      width: 24,
                      height: 26,
                      // ignore: deprecated_member_use
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: 'copy_right'.tr,
                          fontSize: 18,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                        SizedBox(width: DEVICE_WIDTH * 0.02),
                        SvgPicture.asset(
                          iconCopyRight,
                          width: 24,
                          height: 26,
                          // ignore: deprecated_member_use
                          color: const Color(AppColors.colorLineAndText),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.06),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: const Color(
                                      AppColors.colorPointerborder,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: SvgPicture.asset(iconClose),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.025),
                                        Align(
                                          child: CustomText(
                                            textAlign: TextAlign.center,
                                            text: 'are_you_sure_change_pattern'
                                                .tr,
                                            fontSize: 16,
                                            type: CustomTextType.title,
                                            color: const Color(
                                              AppColors.colorLineAndText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Btn(
                                              colorText: const Color(
                                                AppColors.colorLineAndText,
                                              ),
                                              size: 12,
                                              customWidth: 0.3,
                                              onPressed: () {
                                                final LoginController login =
                                                    Get.find();

                                                login.showForgetPatter = false;
                                                // ignore: always_specify_types
                                                Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                    Get.toNamed(routeLogin);
                                                    login.showPage =
                                                        'forgetPassword';
                                                    login.update();
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  AppColors
                                                      .colorWhiteSelectedType,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      DEVICE_HEIGHT * 0.002,
                                                ),
                                              ),
                                              text: 'yes'.tr,
                                            ),
                                          ),
                                          SizedBox(width: DEVICE_WIDTH * 0.04),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Btn(
                                              colorText: const Color(
                                                AppColors
                                                    .colorWhiteSelectedType,
                                              ),
                                              size: 12,
                                              customWidth: 0.3,
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  AppColors.colorLineAndText,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      DEVICE_HEIGHT * 0.002,
                                                ),
                                              ),
                                              text: 'no'.tr,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ContainerSettings(
                              title: 'security_mode'.tr,
                              icon: iconCopyRight,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeLogin);
                            },
                            child: ContainerSettings(
                              title: 'number_phone'.tr,
                              icon: iconNumber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
