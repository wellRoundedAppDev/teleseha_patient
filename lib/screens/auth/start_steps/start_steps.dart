import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';
import '../form_user_data/form_data_user.dart';

class StartSteps extends StatelessWidget {
  StartSteps({super.key});

  LoginController login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              SizedBox(height: DEVICE_HEIGHT * 0.1),
              Container(
                margin: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        iconBack,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset(
                      iconLogoLogin,
                      width: 142,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.012),
              if (controller.currentStep == 1)
                Column(
                  children: <Widget>[
                    SizedBox(height: DEVICE_HEIGHT * 0.043),
                    PatternLock(),
                    SizedBox(height: DEVICE_HEIGHT * 0.067),
                    StepIndicator(
                      currentStep: controller.currentStep,
                      totalSteps: controller.numberOfStep,
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.035),
                  ],
                )
              else
                controller.currentStep == 2
                    ? Column(
                        children: <Widget>[
                          SizedBox(height: DEVICE_HEIGHT * 0.053),
                          FormDataUser(isFromProfile: true),
                          SizedBox(height: DEVICE_HEIGHT * 0.067),
                          StepIndicator(
                            currentStep: controller.currentStep,
                            totalSteps: controller.numberOfStep,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.04),
                        ],
                      )
                    : const Text('test'),
              if (controller.currentStep < controller.numberOfStep)
                Btn(
                  onPressed: () {
                    controller.onNextButtonPress();
                  },
                  text: 'next'.tr,
                ),
            ],
          ),
        );
      },
    );
  }
}
