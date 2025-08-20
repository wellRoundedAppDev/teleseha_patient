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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      iconBack,
                      width: DEVICE_WIDTH * 0.04,
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                title: SizedBox(
                  width: DEVICE_WIDTH * 0.425,
                  height: DEVICE_HEIGHT * 0.0108,
                  child: LinearProgressIndicator(
                    value: controller.currentStep == 1
                        ? 0.4
                        : controller.currentStep == 2
                        ? 0.6
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        controller.currentStep != controller.numberOfStep
                        ? const Color(AppColors.backgroundColorLine)
                        : const Color(AppColors.colorSuccessLine),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(
                        AppColors.colorLineAndText,
                      ).withValues(alpha: 0.2),
                    ),
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(height: DEVICE_HEIGHT * 0.012),
              const Logo(),
              if (controller.currentStep == 1)
                Column(
                  children: <Widget>[
                    SizedBox(height: DEVICE_HEIGHT * 0.043),
                    Container(child: PatternLock()),
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
                          Container(child: FormDataUser()),
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
