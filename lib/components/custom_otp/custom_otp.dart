import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../general_exports.dart';

class CustomOtp extends StatelessWidget {
  CustomOtp({super.key});

  LoginController login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: DEVICE_HEIGHT * 0.1),
                const Logo(),
                SizedBox(height: DEVICE_HEIGHT * 0.10),
                Center(
                  child: Column(
                    children: <Widget>[
                      if (login.page == 'signUp')
                        SizedBox(height: DEVICE_HEIGHT * 0.015)
                      else
                        const SizedBox(),
                      SizedBox(height: DEVICE_HEIGHT * 0.014),
                      SizedBox(
                        width: DEVICE_WIDTH * 0.9,
                        child: Column(
                          children: <Widget>[
                            CustomText(
                              text: 'confirm'.tr,
                              type: CustomTextType.title,
                              fontSize: 24,
                              color: const Color(AppColors.colorTextBlue),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.035),
                            Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '${'input_confirm'.tr} ',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(AppColors.colorInputConfirm),
                                      height: 24 / 14,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '0123456890',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(AppColors.colorLineAndText),
                                      height: 24 / 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.018),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (controller.showOtpError)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: DEVICE_HEIGHT * 0.012,
                                    ),
                                    child: CustomText(
                                      text: 'valid_code'.tr,
                                      type: CustomTextType.title,
                                      fontSize: 11,
                                      color: const Color(AppColors.colorError),
                                    ),
                                  ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Pinput(
                                    controller: controller.otpController,
                                    length: 6,
                                    defaultPinTheme: defaultPinTheme
                                        .copyDecorationWith(
                                          border: Border.all(
                                            color: controller.showOtpError
                                                ? const Color(
                                                    AppColors.colorError,
                                                  )
                                                : const Color(
                                                    AppColors.colorWhite,
                                                  ),
                                          ),
                                          color: const Color(
                                            AppColors.colorWhiteSelectedType,
                                          ),
                                        ),
                                    submittedPinTheme: defaultPinTheme
                                        .copyDecorationWith(
                                          border: Border.all(
                                            color: controller.showOtpError
                                                ? const Color(
                                                    AppColors.colorError,
                                                  )
                                                : const Color(
                                                    AppColors.colorSuccessLine,
                                                  ),
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
                            SizedBox(height: DEVICE_HEIGHT * 0.018),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text.rich(
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
                                            AppColors.colorLineAndText,
                                          ).withValues(alpha: 60),
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            controller.restartTimer();
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                CustomText(
                                  text: controller.formattedTime,
                                  color: const Color(AppColors.colorNumber),
                                ),
                              ],
                            ),
                            if (login.page != 'signIn')
                              SizedBox(height: DEVICE_HEIGHT * 0.07),
                            if (login.page == 'signUp')
                              StepIndicator(
                                currentStep: controller.currentStep,
                                totalSteps: controller.numberOfStep,
                              )
                            else
                              const SizedBox(),
                            if (login.page != 'signIn')
                              SizedBox(height: DEVICE_HEIGHT * 0.048),
                            if (login.page == 'signIn')
                              SizedBox(height: DEVICE_HEIGHT * 0.085),
                            Btn(
                              onPressed: () {
                                controller.checkOtpToNextPage();
                              },
                              text: 'confirm_otp'.tr,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        color: Colors.black.withValues(alpha: 0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  ),
);
