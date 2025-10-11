import '../../../general_exports.dart';
import '../form_user_data/form_data_user.dart';

class StartSteps extends StatelessWidget {
  StartSteps({super.key});

  LoginController login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (StartStepsController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              SizedBox(height: DEVICE_HEIGHT * 0.1),
              Logo(),
              SizedBox(height: DEVICE_HEIGHT * 0.012),
              if (controller.currentStep == 2)
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
                controller.currentStep == 3
                    ? Column(
                        children: <Widget>[
                          SizedBox(height: DEVICE_HEIGHT * 0.053),
                          // FormDataUser(isFromProfile: true),
                          FormDataUser(),
                          SizedBox(height: DEVICE_HEIGHT * 0.067),
                          StepIndicator(
                            currentStep: controller.currentStep,
                            totalSteps: controller.numberOfStep,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.04),
                        ],
                      )
                    : const SizedBox.shrink(),
              if (controller.currentStep <= controller.numberOfStep)
                Btn(
                  onPressed: () {
                    controller.onNextButtonPress();
                  },
                  text: 'next'.tr,
                  isLoading: controller.isLoading,
                ),
            ],
          ),
        );
      },
    );
  }
}
