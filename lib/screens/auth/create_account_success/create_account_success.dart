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
          children: [
            const Logo(),
            SizedBox(height: DEVICE_HEIGHT * 0.07),
            SvgPicture.asset(
              successMark,
              width: DEVICE_WIDTH * 0.15,
              height: DEVICE_HEIGHT * 0.15,
              fit: BoxFit.cover,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              'success'.tr,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.colorTextBlue),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              'thinks_create_account'.tr,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(AppColors.colorThinks),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Btn(
              text: 'next'.tr,
              color: const Color(AppColors.colorLineAndText),
              onPressed: () {
                Get.toNamed(routeDiagnosis);
              },
            ),
          ],
        ),
      ),
    );
  }
}
