import 'package:flutter_svg/flutter_svg.dart';

import '../../../../general_exports.dart';

class FingerPrint extends StatelessWidget {
  const FingerPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FingerPrintController>(
      init: FingerPrintController(),
      builder: (FingerPrintController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: TextButton(
                onPressed: () {
                  Get.toNamed(routeLogin);
                },
                child: CustomText(
                  text: 'skip'.tr,
                  type: CustomTextType.title,
                  fontSize: 10,
                  color: const Color(AppColors.colorBlack),
                ),
              ),
            ),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: DEVICE_HEIGHT * 0.03,
                horizontal: DEVICE_HEIGHT * 0.03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: 'title_foot_print'.tr,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  CustomText(
                    text: 'text_foot_print'.tr,
                    color: const Color(AppColors.colorSelectDropDown),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  SvgPicture.asset(
                    fingerPrint,
                    width: DEVICE_WIDTH * 0.17,
                    height: DEVICE_HEIGHT * 0.17,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  CustomText(
                    text: 'put_your_finger'.tr,
                    fontSize: 21,
                    color: const Color(AppColors.colorLineAndText),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Btn(
                    onPressed: () {
                      controller.startBiometricAuth();
                    },
                    text: 'save'.tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
