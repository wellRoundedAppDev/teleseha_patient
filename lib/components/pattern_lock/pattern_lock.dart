import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../general_exports.dart';

class PatternLock extends StatelessWidget {
  const PatternLock({super.key});
  Widget _buildPatternArea({
    required PatternState state,
    required List<int> pattern,
    required Function() onStart,
    required Function(List<int>) onUpdate,
    required Function(List<int>) onEnd,
  }) {
    return Center(
      child: PatternContainer(
        pattern: pattern,
        state: state,
        onStart: onStart,
        onUpdate: onUpdate,
        onEnd: onEnd,
      ),
    );
  }

  Widget _buildStepsPattern(StartStepsController stepsController) {
    return Center(
      child: PatternStyle(
        data: PatternStyleData(
          linePaint: (PatternState state) => Paint()
            ..strokeWidth = 2
            ..color = switch (state) {
              PatternState.normal => const Color(AppColors.colorPointer),
              PatternState.active => Colors.blue,
              PatternState.success => const Color(AppColors.colorSuccessLine),
              PatternState.error => Colors.red,
            }
            ..style = PaintingStyle.stroke,
          dotBuilder: (PatternState state) {
            final Color color = switch (state) {
              PatternState.normal => const Color(AppColors.colorPointer),
              PatternState.active => Colors.blue,
              PatternState.success => Colors.green,
              PatternState.error => Colors.red,
            };
            return Container(
              width: DEVICE_WIDTH * 0.04,
              height: DEVICE_HEIGHT * 0.04,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            );
          },
          dotPainter: (_, __, ___) {},
        ),
        child: SizedBox(
          width: DEVICE_WIDTH * 0.67,
          height: DEVICE_HEIGHT * 0.24,
          child: PatternView(
            state: stepsController.state,
            value: stepsController.inputPattern,
            onStart: stepsController.startPattern,
            onUpdate: stepsController.updatePattern,
            onEnd: (List<int> pattern) {
              stepsController.inputPattern = pattern;
              stepsController.update();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        final bool isSignUp = controller.page == 'signUp';
        final StartStepsController? stepsController = isSignUp
            ? Get.find<StartStepsController>()
            : null;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: controller.page != 'signUp'
              ? Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: AppBar(
                      leading: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (controller.page == 'signIn') {
                            final StartStepsController? startStepsController =
                                Get.isRegistered<StartStepsController>()
                                ? Get.find<StartStepsController>()
                                : null;
                            if (startStepsController != null) {
                              startStepsController.timer?.cancel();
                              startStepsController.secondsRemaining = 70;
                              startStepsController.startCountdown();
                              startStepsController.update();
                            }
                            Get.to(() => CustomOtp());
                          } else if (controller.page == 'update' ||
                              controller.page == 'verifyPattern') {
                            Future.delayed(const Duration(seconds: 2), () {
                              controller.updatePage('signIn');
                            });
                          }
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
                      title:
                          controller.page == 'signIn' ||
                              controller.page == 'update'
                          ? SizedBox(
                              width: DEVICE_WIDTH * 0.425,
                              height: DEVICE_HEIGHT * 0.0108,
                              child: LinearProgressIndicator(
                                value: controller.linePerecentage,
                                borderRadius: BorderRadius.circular(15),
                                backgroundColor: const Color(
                                  AppColors.backgroundColorLine,
                                ),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color(
                                    AppColors.colorLineAndText,
                                  ).withAlpha(50),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      centerTitle: true,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.035,
                        horizontal: DEVICE_HEIGHT * 0.03,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(controller.page),
                          const Logo(),
                          SizedBox(height: DEVICE_HEIGHT * 0.0425),
                          if (controller.page == 'signIn')
                            CustomText(
                              text: 'create_input_pattern'.tr,
                              fontSize: 24,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorTextBlue),
                            )
                          else if (controller.page == 'update' ||
                              controller.page == 'verifyPattern')
                            CustomText(
                              text: 'create_pattern'.tr,
                              fontSize: 24,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorTextBlue),
                            ),
                          SizedBox(height: DEVICE_HEIGHT * 0.13),
                          _buildPatternArea(
                            state: controller.state,
                            pattern: controller.inputPattern,
                            onStart: controller.startPattern,
                            onUpdate: controller.updatePattern,
                            onEnd: (List<int> pattern) {
                              controller.inputPattern = pattern;
                              if (controller.page == 'signIn') {
                                controller.validatePattern();
                              }
                            },
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.053),
                          if (controller.page == 'signIn' &&
                              controller.showForgetPatter)
                            Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '${'are_you_forget_pass'.tr} ',
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(AppColors.colorInputConfirm),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'create_new_pattern'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(AppColors.colorLineAndText),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        controller.showForgetPatter = false;
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            controller.updatePage('update');
                                          },
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: DEVICE_HEIGHT * 0.10),
                          if (controller.page == 'update' ||
                              controller.page == 'verifyPattern')
                            Btn(
                              onPressed: () {
                                controller.state = PatternState.active;
                                controller.createVerificationForExistingUser();
                                controller.update();
                              },
                              text: controller.page == 'update'
                                  ? 'next'.tr
                                  : 'save'.tr,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    CustomText(
                      text: 'create_pattern'.tr,
                      fontSize: 24,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorTextBlue),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.16),
                    if (stepsController != null)
                      _buildStepsPattern(stepsController),
                  ],
                ),
        );
      },
    );
  }
}
