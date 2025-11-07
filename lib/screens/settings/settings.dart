import 'package:flutter_svg/svg.dart';

import '../../components/containerSettings.dart';
import '../../general_exports.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (SettingsController controller) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_HEIGHT * 0.007,
                ),
                margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: 'settings'.tr,
                                    fontSize: 18,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  SvgPicture.asset(
                                    iconSettings1,
                                    width: 24,
                                    height: 26,
                                    // ignore: deprecated_member_use
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                ],
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
                                      final BottomNavController bottomNav =
                                          Get.find();
                                      bottomNav.selectedIndexBottomNav.value =
                                          0;
                                    },
                                    child: ContainerSettings(
                                      title: 'profile'.tr,
                                      icon: iconDataUser,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  ContainerSettings(
                                    title: 'settings_notificion'.tr,
                                    isActive: false,
                                    isActiveSwitch: true,
                                    icon: iconNotificationBLue,
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
                                    onTap: () {
                                      Get.toNamed(routeFormDiagnosis);
                                    },
                                    child: ContainerSettings(
                                      title: 'medical_history1'.tr,
                                      icon: iconMdeicalHistory,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(routeCopyRight);
                                    },
                                    child: ContainerSettings(
                                      title: 'copy_right_setting'.tr,
                                      icon: copyRightSetting,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  ContainerSettings(
                                    title: 'copy'.tr,
                                    icon: copy,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(routeTechnicalSupport);
                                    },
                                    child: ContainerSettings(
                                      title: 'technical_support'.tr,
                                      icon: tecTeam,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  ContainerSettings(
                                    title: 'whoAreWe'.tr,
                                    icon: iconHowAreWe,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                  GestureDetector(
                                    onTap: () {
                                      if (!controller.isLoading) {
                                        controller.logOut();
                                      }
                                    },
                                    child: ContainerSettings(
                                      title: 'log_out'.tr,
                                      icon: iconLogOut,
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
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
