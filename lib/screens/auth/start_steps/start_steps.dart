import '../../../general_exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartSteps extends StatelessWidget {
  const StartSteps({super.key});

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
                title: SizedBox(
                  width: DEVICE_WIDTH * 0.425,
                  height: DEVICE_HEIGHT * 0.0108,
                  child: LinearProgressIndicator(
                    value: controller.currentStep == 1
                        ? 0.4
                        : controller.currentStep == 2
                        ? 0.8
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: controller.currentStep != 3
                        ? Color(AppColors.backgroundColorLine)
                        : Color(AppColors.colorSuccessLine),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(AppColors.colorLineAndText).withValues(alpha: 0.2),
                    ),
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.03,
              horizontal: controller.currentStep == 1
                  ? DEVICE_HEIGHT * 0.02
                  : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Column(
                    children: [
                      controller.currentStep == 1
                          ? StepOne()
                          : controller.currentStep == 2
                          ? StepTow()
                          : controller.currentStep == 3
                          ? StepThree()
                          : Text(''),
                      SizedBox(height: DEVICE_HEIGHT * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          int stepNumber = 3 - index;
                          return Row(
                            children: [
                              ContainerSteps(
                                myAlpha: controller.currentStep == stepNumber
                                    ? 250
                                    : 80,
                              ),
                              if (index != 3)
                                SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.035),
                      StepsBtn(
                        onPressed: () {
                          controller.onNextButtonPress();
                          // if (controller.checkVaildsSteps()) {
                          //   if (controller.currentStep ==
                          //       controller.numberOfStep) {
                          //     Get.toNamed(routeCreateAccountSuccess);
                          //   } else {
                          //     controller.currentStep++;
                          //   }
                          // }
                        },
                        text: 'next'.tr,
                      ),
                    ],
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
