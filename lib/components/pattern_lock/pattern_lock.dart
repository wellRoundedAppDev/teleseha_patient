import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../general_exports.dart';

class PatternLock extends StatelessWidget {
  const PatternLock({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        // final bool isSignIn = Get.arguments?['isSignIn'] ?? true;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
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
                  // title: isSignIn
                  //     ? SizedBox(
                  //         width: DEVICE_WIDTH * 0.425,
                  //         height: DEVICE_HEIGHT * 0.0108,
                  //         child: LinearProgressIndicator(
                  //           value: controller.argumentValue,
                  //           borderRadius: BorderRadius.circular(15),
                  //           backgroundColor: const Color(
                  //             AppColors.backgroundColorLine,
                  //           ),
                  //           valueColor: AlwaysStoppedAnimation<Color>(
                  //             const Color(
                  //               AppColors.colorLineAndText,
                  //             ).withValues(alpha: 0.2),
                  //           ),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  // centerTitle: true,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.035,
                  horizontal: DEVICE_HEIGHT * 0.02,
                ),
                child: Column(
                  children: <Widget>[
                    const Logo(),
                    SizedBox(height: DEVICE_HEIGHT * 0.0425),
                    CustomText(
                      text: 'create_input_pattern'.tr,
                      fontSize: 24,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorTextBlue),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.13),
                    Column(
                      children: <Widget>[
                        // Text('$isSignIn'),
                        Center(
                          child: PatternStyle(
                            data: PatternStyleData(
                              linePaint: (PatternState state) => Paint()
                                ..strokeWidth = 2
                                ..color = switch (state) {
                                  PatternState.normal => Colors.grey,
                                  PatternState.active => Colors.blue,
                                  PatternState.success => const Color(
                                    AppColors.colorSuccessLine,
                                  ),
                                  PatternState.error => Colors.red,
                                }
                                ..style = PaintingStyle.stroke,
                              dotBuilder: (PatternState state) {
                                final Color color = switch (state) {
                                  PatternState.normal => const Color(
                                    AppColors.colorPointer,
                                  ),
                                  PatternState.active => Colors.blue,
                                  PatternState.success => Colors.green,
                                  PatternState.error => Colors.red,
                                };
                                return Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                              dotPainter: (_, __, ___) {},
                            ),
                            child: SizedBox(
                              width: 270,
                              height: 200,
                              child: PatternView(
                                state: controller.state,
                                value: controller.inputPattern,
                                onStart: controller.startPattern,
                                onUpdate: controller.updatePattern,
                                onEnd: (List<int> pattern) {
                                  controller.updatePattern(pattern);
                                  controller.validatePattern();
                                },
                              ),
                            ),
                            // child: isSignIn
                            //     ? SizedBox(
                            //         width: 270,
                            //         height: 200,
                            //         child: PatternView(
                            //           state: controller.state,
                            //           value: controller.inputPattern,
                            //           onStart: controller.startPattern,
                            //           onUpdate: controller.updatePattern,
                            //           onEnd: (List<int> pattern) {
                            //             controller.updatePattern(pattern);
                            //             controller.validatePattern();
                            //           },
                            //         ),
                            //       )
                            //     : SizedBox(
                            //         width: DEVICE_WIDTH * 0.72,
                            //         height: DEVICE_HEIGHT * 0.25,
                            //         child: PatternView(
                            //           state: controller.state,
                            //           value: controller.inputPattern,
                            //           onStart: () {},
                            //           onUpdate: (_) {},
                            //           onEnd: (_) {},
                            //         ),
                            //       ),
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.053),
                        // if (isSignIn)
                        if (controller.showForgetPatter)
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
                                      Get.to(
                                        CustomOtp(),
                                        // CustomOtp(
                                        //   goToRoutePatternOrSuccess:
                                        //       routePatternLock,
                                        // ),
                                      );
                                      controller.showForgetPatter = false;
                                    },
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox(),
                        // if (!controller.checkFunctionRegiserOrSignIn())
                        //   StepsBtn(
                        //     onPressed: () {
                        //       controller.state = PatternState.active;
                        //       controller.update();
                        //     },
                        //     text: 'next'.tr,
                        //   ),
                      ],
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
