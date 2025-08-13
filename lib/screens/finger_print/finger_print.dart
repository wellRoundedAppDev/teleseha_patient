import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

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
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // check userdata about check route steps
                      controller.checkUserAndNavigate();
                    },
                    child: Text(
                      'skep'.tr,
                      style: const TextStyle(
                        color: Color(AppColors.colorReset),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: DEVICE_HEIGHT * 0.03,
                horizontal: DEVICE_HEIGHT * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'title_foot_print'.tr,
                    style: const TextStyle(
                      color: Color(AppColors.colorTextBlue),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Text(
                    'text_foot_print'.tr,
                    style: const TextStyle(
                      color: Color(AppColors.colorSelectDropDown),
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
                    'put_your_finger'.tr,
                    style: const TextStyle(
                      color: Color(AppColors.colorLineAndText),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                      fontSize: 21,
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  StepsBtn(
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
