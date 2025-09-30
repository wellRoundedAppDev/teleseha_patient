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
        margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: DEVICE_WIDTH,
              padding: const EdgeInsets.all(14),
              child: Column(
                children: <Widget>[
                  Row(
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
                  SizedBox(height: DEVICE_HEIGHT * 0.06),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ContainerSettings(
                            title: 'profile'.tr,
                            icon: iconDataUser,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          ContainerSettings(
                            title: 'settings_notificion'.tr,
                            isActive: false,
                            isActiveSwitch: true,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          ContainerSettings(
                            title: 'copy_right'.tr,
                            icon: iconCopyRight,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          ContainerSettings(
                            title: 'technical_support'.tr,
                            icon: iconTechnicalSupport,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          ContainerSettings(
                            title: 'whoAreWe'.tr,
                            icon: iconHowAreWe,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.035),
                          ContainerSettings(
                            title: 'log_out'.tr,
                            icon: iconLogOut,
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
