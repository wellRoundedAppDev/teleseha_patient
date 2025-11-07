import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class TechnicalSupport extends StatelessWidget {
  const TechnicalSupport({super.key});

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
                            text: 'technical_support'.tr,
                            fontSize: 18,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorLineAndText),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.02),
                          SvgPicture.asset(
                            technicalSupport1,
                            width: 24,
                            height: 26,
                            // ignore: deprecated_member_use
                            color: const Color(AppColors.colorLineAndText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  CustomText(
                    text: 'help_technical_support'.tr,
                    fontSize: 14,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorSelectDropDown),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.2),
                  Column(
                    children: <Widget>[
                      Btn(
                        onPressed: () {},
                        text: 'contact_us'.tr,
                        icon: Icons.phone,
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.05),
                      Btn(
                        colorText: const Color(AppColors.colorLineAndText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            AppColors.colorWhiteSelectedType,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: DEVICE_HEIGHT * 0.02,
                          ),
                        ),
                        onPressed: () {},
                        text: 'contacut'.tr,
                        icon: Icons.mail,
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
  }
}
