import 'package:pinput/pinput.dart';

import '../../../general_exports.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  MyAppController get myAppController => Get.find<MyAppController>();
  TimerController get timerController => Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    timerController.startTimerManually();
    return Container(
      width: DEVICE_WIDTH * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'confirm'.tr,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.colorTextBlue),
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.04),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'inputConfirm'.tr + ' ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(AppColors.colorInputConfirm),
                  ),
                ),
                TextSpan(
                  text: '0123456890',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(AppColors.colorLineAndText),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          GetBuilder<TimerController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.isOtpInvalid)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'vaild_code'.tr,
                        style: TextStyle(
                          color: Color(AppColors.colorError),
                          fontSize: 11,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: controller.otpController,
                      validator: (value) {
                        if (value == '') {
                          return 'الرجاء التحقق من الرمز';
                        }
                        return null;
                      },
                      length: 6,
                      defaultPinTheme: defaultPinTheme.copyDecorationWith(
                        border: Border.all(
                          color: controller.isOtpInvalid
                              ? Color(AppColors.colorError)
                              : const Color(AppColors.colorWhite),
                        ),
                        color: const Color(AppColors.colorwhiteSelectedType),
                      ),
                      submittedPinTheme: defaultPinTheme.copyDecorationWith(
                        border: Border.all(
                          color: controller.isOtpInvalid
                              ? Color(AppColors.colorError)
                              : const Color(AppColors.colorLineAndText),
                        ),
                        color: Colors.white,
                      ),
                      pinAnimationType: PinAnimationType.slide,
                      onChanged: (String value) {
                        controller.clearOtpError();
                      },
                      onCompleted: (String pin) {
                        controller.otpController.text = pin;
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  timerController.restartTimer();
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'resend'.tr + ' ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(AppColors.colorReset),
                        ),
                      ),
                      TextSpan(
                        text: 'againResend'.tr,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(
                            AppColors.colorTextBlue,
                          ).withValues(alpha: 60),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder<TimerController>(
                builder: (controller) {
                  return Text(
                    controller.formattedTime,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.colorNumber),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final PinTheme defaultPinTheme = PinTheme(
  width: DEVICE_WIDTH * 0.85,
  height: DEVICE_HEIGHT * 0.05,
  textStyle: Theme.of(
    Get.context!,
  ).textTheme.bodyMedium!.copyWith(fontSize: 15),
  decoration: BoxDecoration(
    color: const Color(AppColors.colorWhite),
    borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
    border: Border.all(color: const Color(AppColors.colorLineAndText)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
);
