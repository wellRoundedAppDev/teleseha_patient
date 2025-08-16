import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../general_exports.dart';

class CustomOtp extends StatelessWidget {
  CustomOtp({super.key, this.goToRoutePatternOrSuccess});

  String? goToRoutePatternOrSuccess;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      iconBack,
                      width: DEVICE_WIDTH * 0.04,
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.02),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const Logo(),
                    SizedBox(height: DEVICE_HEIGHT * 0.014),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.8,
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
                                    fontWeight: FontWeight.w400,
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
                                  padding: const EdgeInsets.only(bottom: 10),
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
                                            AppColors.colorLineAndText,
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
                          SizedBox(height: DEVICE_HEIGHT * 0.079),
                          StepsBtn(
                            onPressed: () {
                              controller.setArgument(goToRoutePatternOrSuccess);
                            },
                            text: 'next'.tr,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  ),
);
