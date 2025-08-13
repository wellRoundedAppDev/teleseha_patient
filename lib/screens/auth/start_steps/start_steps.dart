import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class StartSteps extends StatelessWidget {
  const StartSteps({super.key});

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
                leading: controller.currentStep != 1
                    ? InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.minusSelectedSteps();
                        },
                        child: Center(
                          child: SvgPicture.asset(
                            iconBack,
                            width: DEVICE_WIDTH * 0.04,
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                        ),
                      )
                    : const SizedBox(),
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
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.03,
              horizontal: controller.currentStep == 1
                  ? DEVICE_HEIGHT * 0.02
                  : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.03),
                  Column(
                    children: <Widget>[
                      if (controller.currentStep == 1)
                        const StepOne()
                      else
                        controller.currentStep == 2
                            ? const StepTow()
                            : controller.currentStep == 3
                            ? const StepThree()
                            : const SizedBox(),
                      SizedBox(height: DEVICE_HEIGHT * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (int index) {
                          final int stepNumber = 3 - index;
                          return Row(
                            children: <Widget>[
                              ContainerSteps(
                                alpha: controller.currentStep == stepNumber
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
