import 'package:patient/components/steps_btn/steps_btn.dart';

import '../../../general_exports.dart';

class StartSteps extends StatelessWidget {
  const StartSteps({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form_key = GlobalKey<FormState>();
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: controller.selectedSteps != 1
                    ? InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.selectedSteps--;
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
                    value: controller.selectedSteps == 1
                        ? 0.3
                        : controller.selectedSteps == 2
                        ? 0.7
                        : 1,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        controller.selectedSteps == 1 ||
                            controller.selectedSteps == 2
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
              vertical: controller.selectedSteps != 3
                  ? DEVICE_HEIGHT * 0.03
                  : DEVICE_HEIGHT * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
                  SizedBox(
                    height: controller.selectedSteps != 3
                        ? DEVICE_HEIGHT * 0.06
                        : DEVICE_HEIGHT * 0.04,
                  ),
                  Form(
                    key: form_key,
                    child: Column(
                      children: [
                        controller.selectedSteps == 1
                            ? StepOne()
                            : controller.selectedSteps == 2
                            ? StepTow()
                            : StepThree(),
                        SizedBox(height: DEVICE_HEIGHT * 0.08),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 3 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 2 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 1 ? 1 : 6.5,
                            ),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        StepsBtn(
                          onPressed: () {
                            if (controller.checkVaildType()) {
                              controller.selectedSteps++;
                            }
                          },
                          text: controller.selectedSteps == 3
                              ? 'confirm'.tr
                              : 'next'.tr,
                          //   onNext: () {
                          //     setState(() {
                          //       if (selectedSteps == 3) {
                          //         if (!timerController.checkOtpIsValid()) {
                          //           timerController.markOtpInvalid();
                          //           print(
                          //             "OTP Entered: ${timerController.otpController.text}",
                          //           );
                          //         } else {
                          //           timerController.clearOtpError();
                          //           Get.toNamed('/success');
                          //         }
                          //       } else {
                          //         selectedSteps++;
                          //       }
                          //     });
                          //   },
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

// -------------------------------------------------------
// import '../../../general_exports.dart';

// class StartSteps extends StatefulWidget {
//   const StartSteps({super.key});

//   @override
//   State<StartSteps> createState() => _StartStepsState();
// }

// class _StartStepsState extends State<StartSteps> {
//   PassTypeAndAge change_active = Get.put(PassTypeAndAge());

//   GlobalKey<FormState> form_key = GlobalKey<FormState>();
//   int selectedSteps = 1;

//   @override
//   Widget build(BuildContext context) {
//     final TimerController timerController = Get.put(TimerController());

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: AppBar(
//             leading: selectedSteps != 1
//                 ? InkWell(
//                     focusColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     onTap: () {
//                       setState(() {
//                         selectedSteps--;
//                       });
//                     },
//                     child: Center(
//                       child: SvgPicture.asset(
//                         iconBack,
//                         width: DEVICE_WIDTH * 0.04,
//                         height: DEVICE_HEIGHT * 0.02,
//                       ),
//                     ),
//                   )
//                 : Text(''),
//             title: SizedBox(
//               width: DEVICE_WIDTH * 0.425,
//               height: DEVICE_HEIGHT * 0.0108,
//               child: LinearProgressIndicator(
//                 value: selectedSteps == 1
//                     ? 0.3
//                     : selectedSteps == 2
//                     ? 0.7
//                     : 1,
//                 borderRadius: BorderRadius.circular(15),
//                 backgroundColor: selectedSteps == 1 || selectedSteps == 2
//                     ? Color(AppColors.backgroundColorLine)
//                     : Color(AppColors.colorSuccessLine),
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   Color(AppColors.colorLineAndText).withValues(alpha: 0.2),
//                 ),
//               ),
//             ),
//             centerTitle: true,
//           ),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(
//           vertical: selectedSteps != 3
//               ? DEVICE_HEIGHT * 0.03
//               : DEVICE_HEIGHT * 0.01,
//         ),
//         child: Column(
//           children: [
//             Logo(),
//             SizedBox(
//               height: selectedSteps != 3
//                   ? DEVICE_HEIGHT * 0.06
//                   : DEVICE_HEIGHT * 0.04,
//             ),
//             Form(
//               key: form_key,
//               child: Column(
//                 children: [
//                   selectedSteps == 1
//                       ? StepOne()
//                       : selectedSteps == 2
//                       ? StepTow()
//                       : StepThree(),
//                   SizedBox(height: DEVICE_HEIGHT * 0.08),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ContainerSteps(MyAlpha: selectedSteps == 3 ? 1 : 6.5),
//                       SizedBox(width: DEVICE_HEIGHT * 0.01),
//                       ContainerSteps(MyAlpha: selectedSteps == 2 ? 1 : 6.5),
//                       SizedBox(width: DEVICE_HEIGHT * 0.01),
//                       ContainerSteps(MyAlpha: selectedSteps == 1 ? 1 : 6.5),
//                     ],
//                   ),
//                   SizedBox(height: DEVICE_HEIGHT * 0.03),
//                   GetBuilder<PassTypeAndAge>(
//                     builder: (controller) {
//                       return Text('test');
//                       // return Btn(
//                       //   formKey: form_key,
//                       //   text: selectedSteps == 3 ? 'confirm'.tr : 'next'.tr,
//                       //   checkVaildType: controller.checkVaildType,
//                       //   onNext: () {
//                       //     setState(() {
//                       //       if (selectedSteps == 3) {
//                       //         if (!timerController.checkOtpIsValid()) {
//                       //           timerController.markOtpInvalid();
//                       //           print(
//                       //             "OTP Entered: ${timerController.otpController.text}",
//                       //           );
//                       //         } else {
//                       //           timerController.clearOtpError();
//                       //           Get.toNamed('/success');
//                       //         }
//                       //       } else {
//                       //         selectedSteps++;
//                       //       }
//                       //     });
//                       //   },
//                       // );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
