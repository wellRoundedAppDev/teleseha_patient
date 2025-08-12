import '../../../general_exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FingerPrint extends StatelessWidget {
  const FingerPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: controller.currentStep != 1
                    ? InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.minuseSelectedSteps();
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            iconBack,
                            width: DEVICE_WIDTH * 0.04,
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                        ),
                      )
                    : Text(''),
                backgroundColor: Colors.transparent,
                actions: [
                  controller.currentStep != controller.numberOfStep
                      ? TextButton(
                          onPressed: () {
                            Get.toNamed(routeSteps);
                          },
                          child: Text(
                            'skep'.tr,
                            style: TextStyle(
                              color: Color(AppColors.colorReset),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
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
                children: [
                  Text(
                    'title_foot_print'.tr,
                    style: TextStyle(
                      color: Color(AppColors.colorTextBlue),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Text(
                    'text_foot_print'.tr,
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
                    'put_your_finger'.tr,
                    style: TextStyle(
                      color: Color(AppColors.colorLineAndText),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                      fontSize: 21,
                    ),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  StepsBtn(
                    onPressed: () {
                      controller.checkBiometrics();
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
