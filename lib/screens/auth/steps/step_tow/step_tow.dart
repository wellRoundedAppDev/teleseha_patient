import 'package:pattern_dots/pattern_dots.dart';

import '../../../../general_exports.dart';

class StepTow extends StatelessWidget {
  const StepTow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              CustomText(
                text: 'create_pattern'.tr,
                fontSize: 24,
                type: CustomTextType.title,
                color: const Color(AppColors.colorTextBlue),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.1),
              Center(
                child: PatternStyle(
                  data: PatternStyleData(
                    tapRange: 9,
                    linePaint: (PatternState state) => Paint()
                      ..strokeWidth = 2
                      ..color = switch (state) {
                        PatternState.normal => Colors.grey,
                        PatternState.active => Colors.blue,
                        PatternState.success => Colors.green,
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
                        decoration: ShapeDecoration(
                          shape: const CircleBorder(),
                          color: color,
                        ),
                      );
                    },
                    dotPainter:
                        (PatternState state, Canvas canvas, Offset center) {},
                  ),
                  child: SizedBox(
                    width: DEVICE_WIDTH * 0.72,
                    height: DEVICE_HEIGHT * 0.25,
                    child: PatternView(
                      state: controller.state,
                      value: controller.patterns,
                      onStart: () {
                        controller.state = PatternState.active;
                        controller.patterns = <int>[];
                        controller.update();
                      },
                      onUpdate: (List<int> value) {
                        controller.patterns = value;
                        controller.update();
                      },
                      onEnd: (List<int> value) {
                        controller.patterns = value;
                        controller.canGoToStepThree();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
