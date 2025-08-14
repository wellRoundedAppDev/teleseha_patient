import 'package:pinput/pinput.dart';

import '../../../../general_exports.dart';

class StepFour extends StatelessWidget {
  const StepFour({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (StartStepsController controller) {
        controller.secondsRemaining == 70 && controller.timer == null
            ? controller.startCountdown()
            // ignore: unnecessary_statements
            : null;
        return SizedBox(
          width: DEVICE_WIDTH * 0.8,
          child: Column(
            children: <Widget>[
              CustomText(
                text: 'confirm'.tr,
                type: CustomTextType.title,
                fontSize: 24,
                color: const Color(AppColors.colorTextBlue),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.04),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '${'input_confirm'.tr} ',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(AppColors.colorInputConfirm),
                      ),
                    ),
                    const TextSpan(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (controller.showOtpError)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'valid_code'.tr,
                        style: const TextStyle(
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
                      length: 6,
                      defaultPinTheme: defaultPinTheme.copyDecorationWith(
                        border: Border.all(
                          color: controller.showOtpError
                              ? const Color(AppColors.colorError)
                              : const Color(AppColors.colorWhite),
                        ),
                        color: const Color(AppColors.colorWhiteSelectedType),
                      ),
                      submittedPinTheme: defaultPinTheme.copyDecorationWith(
                        border: Border.all(
                          color: controller.showOtpError
                              ? const Color(AppColors.colorError)
                              : const Color(AppColors.colorSuccessLine),
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
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      controller.restartTimer();
                    },
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: '${'resend'.tr} ',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(AppColors.colorReset),
                            ),
                          ),
                          TextSpan(
                            text: 'again_resend'.tr,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(
                                AppColors.colorTextBlue,
                              ).withValues(alpha: 60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    controller.formattedTime,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.colorNumber),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  ),
);
