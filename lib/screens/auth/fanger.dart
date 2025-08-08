import '../../general_exports.dart';

class Fanger extends StatelessWidget {
  const Fanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.06,
          vertical: DEVICE_HEIGHT * 0.12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              'titleFootprint'.tr,
              style: TextStyle(
                color: Color(AppColors.colorTextBlue),
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo',
                fontSize: 20,
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              'textFootprint'.tr,
              style: TextStyle(
                color: Color(AppColors.colorselectDropDown),
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
                fontSize: 14,
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            SvgPicture.asset(
              footPrint,
              width: DEVICE_WIDTH * 0.15,
              height: DEVICE_HEIGHT * 0.15,
              fit: BoxFit.cover,
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Text(
              'putYourFinger'.tr,
              style: TextStyle(
                color: Color(AppColors.colorLineAndText),
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
                fontSize: 21,
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Row(
              children: [
                Expanded(
                  child: Btn(
                    onNext: () {},
                    text: 'again'.tr,
                    color: Color(AppColors.colorTextBlueBlur),
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.04),
                Expanded(
                  child: Btn(
                    onNext: () => Get.toNamed(routeSteps),
                    text: 'save'.tr,
                    color: Color(AppColors.colorLineAndText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
