import 'package:patient/components/steps_btn/steps_btn.dart';

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
                        ? 0.7
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        controller.currentSteps == 1 ||
                            controller.currentSteps == 2
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
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
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
                            : StepThree(),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 3 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 2 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.currentSteps == 1 ? 1 : 6.5,
                            ),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        controller.currentSteps != 3
                            ? StepsBtn(
                                onPressed: () {
                                  controller.checkAllVaildsStepsOneAndTow()
                                      ? controller.currentSteps++
                                      : '';
                                },
                                text: controller.currentSteps == 3
                                    ? 'confirm'.tr
                                    : 'next'.tr,
                              )
                            : Btn(
                                text: 'next'.tr,
                                color: Color(AppColors.colorLineAndText),
                                onPressed: () {
                                  controller.checkOtp();
                                },
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
