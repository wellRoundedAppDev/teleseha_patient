import 'package:flutter/gestures.dart';
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
    return PatternStyle(
      data: PatternStyleData(
        tapRange: 24,
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
          state: state,
          value: pattern,
          onStart: onStart,
          onUpdate: onUpdate,
          onEnd: onEnd,
        ),
      ),
    );
  }

  Widget _buildStepsPattern(StartStepsController stepsController) {
    return Center(
      child: PatternStyle(
        data: PatternStyleData(
          tapRange: 24,
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
      builder: (LoginController controller) {
        final bool isSignUp = controller.page == 'signUp';
        final StartStepsController? stepsController = isSignUp
            ? Get.find<StartStepsController>()
            : null;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: controller.page != 'signUp'
              ? Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.035,
                        horizontal: DEVICE_HEIGHT * 0.03,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: DEVICE_HEIGHT * 0.038,
                              horizontal: DEVICE_HEIGHT * 0.03,
                            ),
                            child: const Directionality(
                              textDirection: TextDirection.rtl,
                              child: Logo(),
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.13),
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
                          if (controller.isLoading)
                            const CircularProgressIndicator()
                          else
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
                          // SizedBox(height: DEVICE_HEIGHT * 0.0),
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
                                        // ignore: always_specify_types
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            Get.to(() => CustomOtp());
                                          },
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: DEVICE_HEIGHT * 0.05),
                          if (controller.page == 'update' ||
                              controller.page == 'verifyPattern')
                            Column(
                              children: <Widget>[
                                Btn(
                                  onPressed: () {
                                    controller.state = PatternState.active;
                                    controller
                                        .createVerificationForExistingUser();
                                    controller.update();
                                  },
                                  text: controller.page == 'update'
                                      ? 'next'.tr
                                      : 'save'.tr,
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.03),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Btn(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        AppColors.colorWhiteSelectedType,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: DEVICE_HEIGHT * 0.02,
                                      ),
                                    ),
                                    colorText: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                    onPressed: () {
                                      controller.inputPattern = <int>[];
                                      controller.state = PatternState.normal;
                                      controller.update();
                                    },
                                    text: 'again'.tr,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : !controller.isLoading
              ? Column(
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
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
