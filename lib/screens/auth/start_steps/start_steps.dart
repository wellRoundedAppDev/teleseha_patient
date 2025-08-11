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
                actions: [
                  controller.currentSteps == 1
                      ? TextButton(
                          onPressed: () {
                            controller.currentSteps++;
                            controller.update();
                          },
                          child: Text(
                            'skep'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : Text(''),
                ],
                backgroundColor: Colors.transparent,
                title: SizedBox(
                  width: DEVICE_WIDTH * 0.425,
                  height: DEVICE_HEIGHT * 0.0108,
                  child: LinearProgressIndicator(
                    value: controller.currentSteps == 1
                        ? 0.2
                        : controller.currentSteps == 2
                        ? 0.4
                        : controller.currentSteps == 3
                        ? 0.8
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
                  controller.currentSteps == controller.numberOfAllSteps
                      ? Container()
                      : Logo(),
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
                            : controller.currentSteps ==
                                  controller.numberOfAllSteps
                            ? StepFour()
                            : Text(''),
                        controller.currentSteps == 1 ||
                                controller.currentSteps ==
                                    controller.numberOfAllSteps
                            ? SizedBox(height: DEVICE_HEIGHT * 0.05)
                            : SizedBox(height: DEVICE_HEIGHT * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            int stepNumber = 4 - index;
                            return Row(
                              children: [
                                ContainerSteps(
                                  MyAlpha: controller.currentSteps == stepNumber
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
                                            controller.checkBiometrics();
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
                                  controller.currentSteps ==
                                          controller.numberOfAllSteps
                                      ? controller.checkAllVaildsSteps()
                                      : controller.checkAllVaildsSteps()
                                      ? controller.currentSteps++
                                      : '';
                                },
                                text:
                                    controller.currentSteps ==
                                        controller.numberOfAllSteps
                                    ? 'confirm'.tr
                                    : 'next'.tr,
                              ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        controller.currentSteps == 1
                            ? Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'check_skep'.tr,
                                  style: TextStyle(
                                    color: Color(AppColors.colorTextSkep),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            : Text(''),
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
