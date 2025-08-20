import 'package:pattern_dots/pattern_dots.dart';

import '../../general_exports.dart';

class PatternContainer extends StatelessWidget {
  const PatternContainer({
    required this.pattern,
    required this.state,
    required this.onStart,
    required this.onUpdate,
    required this.onEnd,
    super.key,
  });
  final List<int> pattern;
  final PatternState state;
  final void Function() onStart;
  final void Function(List<int>) onUpdate;
  final void Function(List<int>) onEnd;

  @override
  Widget build(BuildContext context) {
    return PatternStyle(
      data: PatternStyleData(
        linePaint: (PatternState s) => Paint()
          ..strokeWidth = 2
          ..color = switch (s) {
            PatternState.normal => const Color(AppColors.colorPointer),
            PatternState.active => Colors.blue,
            PatternState.success => Colors.green,
            PatternState.error => Colors.red,
          }
          ..style = PaintingStyle.stroke,
        dotBuilder: (PatternState s) {
          final Color color = switch (s) {
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
}
