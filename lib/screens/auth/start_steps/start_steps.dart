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
                        ? 0.2
                        : controller.currentStep == 2
                        ? 0.4
                        : controller.currentStep == 3
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
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.02,
              horizontal: controller.currentStep == 1
                  ? DEVICE_HEIGHT * 0.02
                  : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  if (controller.currentStep == 1 ||
                      controller.currentStep == controller.numberOfStep)
                    SizedBox(height: DEVICE_HEIGHT * 0.03)
                  else
                    SizedBox(height: DEVICE_HEIGHT * 0.01),
                  Column(
                    children: <Widget>[
                      if (controller.currentStep == 1)
                        const StepOne()
                      else
                        // controller.currentStep == 2     ?
                        //     // ? controller.currentStep == 3
                        //     // ? const StepThree()
                        //     // // : controller.currentStep == controller.numberOfStep
                        //     // // ? const StepFour()
                        //     : const SizedBox(),
                        SizedBox(height: DEVICE_HEIGHT * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(controller.numberOfStep, (
                          int index,
                        ) {
                          final int stepNumber =
                              controller.numberOfStep - index;
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
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.02,
                        ),
                        child: StepsBtn(
                          onPressed: () {
                            controller.onNextButtonPress();
                          },
                          text: 'next'.tr,
                        ),
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
