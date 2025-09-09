import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class CreateAccountSuccess extends StatelessWidget {
  const CreateAccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: DEVICE_WIDTH,
        margin: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.11),
        child: Column(
          children: <Widget>[
            // const Logo(),
            SizedBox(height: DEVICE_HEIGHT * 0.058),
            SvgPicture.asset(
              successMark,
              width: DEVICE_WIDTH * 0.15,
              height: DEVICE_HEIGHT * 0.15,
              fit: BoxFit.cover,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.038),
            CustomText(
              text: 'success'.tr,
              fontSize: 22,
              type: CustomTextType.title,
              color: const Color(AppColors.colorTextBlue),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            CustomText(
              text: 'thinks_create_account'.tr,
              fontSize: 16,
              type: CustomTextType.button,
              color: const Color(AppColors.colorThinks),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.035),
            Btn(
              text: 'next'.tr,
              color: const Color(AppColors.colorLineAndText),
              onPressed: () {
                // Get.toNamed(routeDiagnosis);
                Get.toNamed(routeScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
