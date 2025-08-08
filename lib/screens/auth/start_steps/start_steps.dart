import '../../../general_exports.dart';

class StartSteps extends StatefulWidget {
  const StartSteps({super.key});

  @override
  State<StartSteps> createState() => _StartStepsState();
}

class _StartStepsState extends State<StartSteps> {
  PassTypeAndAge change_active = Get.put(PassTypeAndAge());

  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  int selectedSteps = 1;

  @override
  Widget build(BuildContext context) {
    final TimerController timerController = Get.put(TimerController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            leading: selectedSteps != 1
                ? InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedSteps--;
                      });
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
                value: selectedSteps == 1
                    ? 0.3
                    : selectedSteps == 2
                    ? 0.7
                    : 1,
                borderRadius: BorderRadius.circular(15),
                backgroundColor: selectedSteps == 1 || selectedSteps == 2
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
        margin: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.1),
        child: Column(
          children: [
            Logo(),
            SizedBox(height: DEVICE_HEIGHT * 0.06),
            Form(
              key: form_key,
              child: Column(
                children: [
                  selectedSteps == 1
                      ? StepOne()
                      : selectedSteps == 2
                      ? StepTow()
                      : StepThree(),
                  SizedBox(height: DEVICE_HEIGHT * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContainerSteps(MyAlpha: selectedSteps == 3 ? 1 : 6),
                      SizedBox(width: DEVICE_HEIGHT * 0.02),
                      ContainerSteps(MyAlpha: selectedSteps == 2 ? 1 : 6),
                      SizedBox(width: DEVICE_HEIGHT * 0.02),
                      ContainerSteps(MyAlpha: selectedSteps == 1 ? 1 : 6),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.03),
                  GetBuilder<PassTypeAndAge>(
                    builder: (controller) {
                      return Btn(
                        formKey: form_key,
                        text: selectedSteps == 3 ? 'confirm'.tr : 'next'.tr,
                        checkVaildType: controller.checkVaildType,
                        onNext: () {
                          setState(() {
                            if (selectedSteps == 3) {
                              print(
                                "OTP Entered: ${timerController.otpController.text}",
                              );
                              Get.toNamed('/success');
                            } else {
                              selectedSteps++;
                            }
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
