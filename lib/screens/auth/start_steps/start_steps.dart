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
                leading: controller.currentSteps != 1
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
                title: SizedBox(
                  width: DEVICE_WIDTH * 0.425,
                  height: DEVICE_HEIGHT * 0.0108,
                  child: LinearProgressIndicator(
                    value: controller.currentSteps == 1
                        ? 0.3
                        : controller.currentSteps == 2
                        ? 0.6
                        : controller.currentSteps == 3
                        ? 8
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        controller.currentSteps == 1 ||
                            controller.currentSteps == 2 ||
                            controller.currentSteps == 3
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
              vertical: controller.currentSteps != 3
                  ? DEVICE_HEIGHT * 0.03
                  : DEVICE_HEIGHT * 0.01,
              horizontal: controller.currentSteps == 1
                  ? DEVICE_HEIGHT * 0.02
                  : 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.currentSteps == 4 ? Container() : Logo(),
                  SizedBox(
                    height: controller.currentSteps != 3
                        ? DEVICE_HEIGHT * 0.06
                        : DEVICE_HEIGHT * 0.04,
                  ),
                  Form(
                    child: Column(
                      children: [
                        controller.currentSteps == 1
                            ? StepOne()
                            : controller.currentSteps == 2
                            ? StepTow()
                            : controller.currentSteps == 3
                            ? StepThree()
                            : controller.currentSteps == 4
                            ? StepFour()
                            : Text(''),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 4 ? 250 : 80,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 3 ? 250 : 80,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 2 ? 250 : 80,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 1 ? 250 : 80,
                            ),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        controller.currentSteps == 1
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: StepsBtn(
                                          onPressed: () {},
                                          text: 'again'.tr,
                                          color: Color(
                                            AppColors.colorTextBlueBlur,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: DEVICE_WIDTH * 0.04),
                                      Expanded(
                                        child: StepsBtn(
                                          onPressed: () {
                                            controller.checkAllVaildsSteps()
                                                ? controller.currentSteps++
                                                : '';
                                          },
                                          text: 'save'.tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : StepsBtn(
                                onPressed: () {
                                  controller.currentSteps == 4
                                      ? controller.checkAllVaildsSteps()
                                      : controller.checkAllVaildsSteps()
                                      ? controller.currentSteps++
                                      : '';
                                },
                                text: controller.currentSteps == 4
                                    ? 'confirm'.tr
                                    : 'next'.tr,
                              ),
                      ],
                    ),
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
