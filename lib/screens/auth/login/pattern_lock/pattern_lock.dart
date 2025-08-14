// views/pattern_lock_view.dart
import 'package:flutter_svg/svg.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../../general_exports.dart';

class PatternLock extends StatelessWidget {
  const PatternLock({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatternLockController>(
      init: PatternLockController(),
      builder: (PatternLockController controller) {
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
                  title: SizedBox(
                    width: DEVICE_WIDTH * 0.425,
                    height: DEVICE_HEIGHT * 0.0108,
                    child: LinearProgressIndicator(
                      value: 1,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: const Color(
                        AppColors.backgroundColorLine,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(
                          AppColors.colorLineAndText,
                        ).withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.05),
                  CustomText(
                    text: 'create_input_pattern'.tr,
                    fontSize: 24,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.08),
                  Center(
                    child: PatternStyle(
                      data: PatternStyleData(
                        tapRange: 4,
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
                        width: 300,
                        height: 300,
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
