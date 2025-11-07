import 'package:flutter_svg/svg.dart';

import '../../components/containerSettings.dart';
import '../../general_exports.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.007),
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: DEVICE_WIDTH,
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
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
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.06),
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: ContainerSettings(
                                title: 'pattern'.tr,
                                icon: iconCopyRight,
                              ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.035),
                            GestureDetector(
                              onTap: () {},
                              child: ContainerSettings(
                                title: 'number_phone'.tr,
                                icon: iconPhoneBlue,
                              ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.035),
                            GestureDetector(
                              onTap: () {},
                              child: ContainerSettings(
                                title: 'call_phones'.tr,
                                icon: phones,
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
      ],
    );
  }
}
