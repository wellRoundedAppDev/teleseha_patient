import 'package:pinput/pinput.dart';

import '../../general_exports.dart';

class CodeVerificationSheet extends StatelessWidget {
  const CodeVerificationSheet({super.key});

  MyAppController get myAppController => Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyAppController>(
        builder: (MyAppController controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('enter_verification_code_sent_to_you'.tr),
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 5,
                defaultPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: const Color(AppColors.transparent)),
                  color: const Color(AppColors.grey),
                ),
                focusedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(color: const Color(AppColors.grey)),
                ),
                submittedPinTheme: defaultPinTheme.copyDecorationWith(
                  border: Border.all(),
                ),
                pinAnimationType: PinAnimationType.slide,
                onChanged: (String value) {
                  myAppController.otp = value;
                },
                onCompleted: (String pin) {
                  myAppController.otp = pin;
                  // myAppController.auth();
                },
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            GestureDetector(
              onTap: () {
                myAppController.resendCode();
              },
              child: Text(
                (myAppController.seconds == 0
                    ? 'resend_code'.tr
                    : '${'resend_code_in'.tr} ${myAppController.seconds} ${'second'.tr}'),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(AppColors.grey),
                ),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.01),
            Text(
              'have_not_received_code'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(AppColors.grey),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.05),
            SizedBox(
              width: DEVICE_WIDTH,
              child: CustomButton(
                text: 'verify'.tr,
                onPressed: myAppController.auth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final PinTheme defaultPinTheme = PinTheme(
  width: DEVICE_WIDTH * 0.12,
  height: DEVICE_HEIGHT * 0.065,
  textStyle: Theme.of(
    Get.context!,
  ).textTheme.bodyMedium!.copyWith(fontSize: 15),
  decoration: BoxDecoration(
    color: const Color(AppColors.transparent),
    borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.01),
    border: Border.all(color: const Color(AppColors.grey)),
  ),
);
