import '../../general_exports.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  PassTypeAndAge change_active = Get.put(PassTypeAndAge());

  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  int selectedSteps = 1;

  @override
  Widget build(BuildContext context) {
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
                    : Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(AppColors.colorLineAndText).withValues(alpha: 0.2),
                ),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Form(
        key: form_key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StepOne(),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContainerSteps(MyAlpha: selectedSteps == 3 ? 1 : 5),
                SizedBox(width: DEVICE_HEIGHT * 0.02),
                ContainerSteps(MyAlpha: selectedSteps == 2 ? 1 : 5),
                SizedBox(width: DEVICE_HEIGHT * 0.02),
                ContainerSteps(MyAlpha: selectedSteps == 1 ? 1 : 5),
              ],
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            // GetBuilder<PassTypeAndAge>(
            //   builder: (controller) {
            //     return controller.viewVaildType ? Text('error') : Text('');
            //   },
            // ),
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            GetBuilder<PassTypeAndAge>(
              builder: (controller) {
                return Container(
                  width: DEVICE_WIDTH * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.02,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        controller.checkVaildType;
                        selectedSteps++;
                      });
                    },
                    child: Text(
                      'next'.tr,
                      style: TextStyle(color: Color(AppColors.colorWhite)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//       // body: GetBuilder<MyAppController>(
//       //   builder: (MyAppController controller) => Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: <Widget>[
//       //       Text('enter_verification_code_sent_to_you'.tr),
//       //       SizedBox(height: DEVICE_HEIGHT * 0.03),
//       //       Directionality(
//       //         textDirection: TextDirection.ltr,
//       //         child: Pinput(
//       //           length: 5,
//       //           defaultPinTheme: defaultPinTheme.copyDecorationWith(
//       //             border: Border.all(color: const Color(AppColors.transparent)),
//       //             color: const Color(AppColors.grey),
//       //           ),
//       //           focusedPinTheme: defaultPinTheme.copyDecorationWith(
//       //             border: Border.all(color: const Color(AppColors.grey)),
//       //           ),
//       //           submittedPinTheme: defaultPinTheme.copyDecorationWith(
//       //             border: Border.all(),
//       //           ),
//       //           pinAnimationType: PinAnimationType.slide,
//       //           onChanged: (String value) {
//       //             myAppController.otp = value;
//       //           },
//       //           onCompleted: (String pin) {
//       //             myAppController.otp = pin;
//       //             // myAppController.auth();
//       //           },
//       //         ),
//       //       ),
//       //       SizedBox(height: DEVICE_HEIGHT * 0.03),
//       //       GestureDetector(
//       //         onTap: () {
//       //           myAppController.resendCode();
//       //         },
//       //         child: Text(
//       //           (myAppController.seconds == 0
//       //               ? 'resend_code'.tr
//       //               : '${'resend_code_in'.tr} ${myAppController.seconds} ${'second'.tr}'),
//       //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//       //             color: const Color(AppColors.grey),
//       //           ),
//       //         ),
//       //       ),
//       //       SizedBox(height: DEVICE_HEIGHT * 0.01),
//       //       Text(
//       //         'have_not_received_code'.tr,
//       //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//       //           color: const Color(AppColors.grey),
//       //         ),
//       //       ),
//       //       SizedBox(height: DEVICE_HEIGHT * 0.05),
//       //       SizedBox(
//       //         width: DEVICE_WIDTH,
//       //         // child: CustomButton(
//       //         //   text: 'verify'.tr,
//       //         //   onPressed: myAppController.auth,
//       //         // ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }

// // final PinTheme defaultPinTheme = PinTheme(
// //   width: DEVICE_WIDTH * 0.12,
// //   height: DEVICE_HEIGHT * 0.065,
// //   textStyle: Theme.of(
// //     Get.context!,
// //   ).textTheme.bodyMedium!.copyWith(fontSize: 15),
// //   decoration: BoxDecoration(
// //     color: const Color(AppColors.transparent),
// //     borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.01),
// //     border: Border.all(color: const Color(AppColors.grey)),
// //   ),
// // );
