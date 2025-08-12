import '../../../general_exports.dart';

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
                        ? 0.2
                        : controller.currentStep == 2
                        ? 0.4
                        : controller.currentStep == 3
                        ? 0.8
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        controller.currentStep == 1 ||
                            controller.currentStep == 2 ||
                            controller.currentStep == 3
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
              vertical: controller.currentStep != 3
                  ? DEVICE_HEIGHT * 0.03
                  : DEVICE_HEIGHT * 0.01,
              horizontal: controller.currentStep == 1
                  ? DEVICE_HEIGHT * 0.02
                  : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.currentStep == controller.numberOfStep
                      ? Container()
                      : Logo(),
                  SizedBox(
                    height: controller.currentStep != 3
                        ? DEVICE_HEIGHT * 0.06
                        : DEVICE_HEIGHT * 0.04,
                  ),
                  Column(
                    children: [
                      controller.currentStep == 1
                          ? StepOne()
                          : controller.currentStep == 2
                          ? StepTow()
                          // : controller.currentStep== 3
                          // ? StepThree()
                          // : controller.currentStep ==
                          //       controller.numberOfStep
                          // ? StepFour()
                          : Text(''),
                      controller.currentStep == controller.numberOfStep
                          ? SizedBox(height: DEVICE_HEIGHT * 0.05)
                          : SizedBox(height: DEVICE_HEIGHT * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          int stepNumber = 4 - index;
                          return Row(
                            children: [
                              ContainerSteps(
                                MyAlpha: controller.currentStep == stepNumber
                                    ? 250
                                    : 80,
                              ),
                              if (index != 3)
                                SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.03),
                      StepsBtn(
                        onPressed: () {
                          controller.checkVaildsSteps()
                              ? controller.currentStep++
                              : '';
                        },
                        text: controller.currentStep == controller.numberOfStep
                            ? 'confirm'.tr
                            : 'next'.tr,
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
