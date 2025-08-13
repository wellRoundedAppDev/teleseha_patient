// import 'package:flutter/foundation.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../../general_exports.dart';

class PatternLockPage extends StatelessWidget {
  const PatternLockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatternLockPageController>(
      init: PatternLockPageController(),
      builder: (PatternLockPageController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
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
                    final MaterialColor color = switch (state) {
                      PatternState.normal => Colors.grey,
                      PatternState.active => Colors.blue,
                      PatternState.success => Colors.green,
                      PatternState.error => Colors.red,
                    };
                    return Container(
                      width: 12,
                      height: 12,
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: color,
                      ),
                    );
                  },
                  dotPainter:
                      (PatternState state, Canvas canvas, Offset center) {},
                ),
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
                    controller.showValidPattern();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
