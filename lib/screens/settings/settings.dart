import 'package:flutter_svg/svg.dart';

import '../../components/containerSettings.dart';
import '../../general_exports.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        iconBack,
                        width: 24,
                        height: 26,
                        color: const Color(AppColors.colorBlack),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomText(
                              text: 'settings'.tr,
                              fontSize: 18,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorLineAndText),
                            ),
                            SizedBox(width: DEVICE_WIDTH * 0.02),
                            SvgPicture.asset(
                              iconSettings1,
                              width: 24,
                              height: 26,
                              // ignore: deprecated_member_use
                              color: const Color(AppColors.colorLineAndText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.06),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              final BottomNavController bottomNav = Get.find();
                              bottomNav.selectedIndexBottomNav.value = 0;
                              bottomNav.update();
                            },
                            child: ContainerSettings(
                              title: 'profile'.tr,
                              icon: iconDataUser,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {},
                            child: ContainerSettings(
                              title: 'settings_notificion'.tr,
                              isActive: false,
                              isActiveSwitch: true,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeSecurity);
                            },
                            child: ContainerSettings(
                              title: 'copy_right'.tr,
                              icon: iconCopyRight,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {},
                            child: ContainerSettings(
                              title: 'medical_history'.tr,
                              icon: iconMdeicalHistory,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routePrivacyPolicy);
                            },
                            child: ContainerSettings(
                              title: 'privacy_policy'.tr,
                              icon: privacyPolicy,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeTermsAndConditions);
                            },
                            child: ContainerSettings(
                              title: 'terms_and_conditions'.tr,
                              icon: terms_and_conditions,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeWhoWeAre);
                            },
                            child: ContainerSettings(
                              title: 'whoAreWe'.tr,
                              icon: iconHowAreWe,
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
