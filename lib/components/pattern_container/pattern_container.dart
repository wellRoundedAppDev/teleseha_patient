import 'package:pattern_dots/pattern_dots.dart';

import '../../general_exports.dart';

class PatternContainer extends StatelessWidget {
  final List<int> pattern;
  final PatternState state;
  final void Function() onStart;
  final void Function(List<int>) onUpdate;
  final void Function(List<int>) onEnd;

  const PatternContainer({
    super.key,
    required this.pattern,
    required this.state,
    required this.onStart,
    required this.onUpdate,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return PatternStyle(
      data: PatternStyleData(
        linePaint: (s) => Paint()
          ..strokeWidth = 2
          ..color = switch (s) {
            PatternState.normal => Colors.grey,
            PatternState.active => Colors.blue,
            PatternState.success => Colors.green,
            PatternState.error => Colors.red,
          }
          ..style = PaintingStyle.stroke,
        dotBuilder: (s) {
          final color = switch (s) {
            PatternState.normal => Colors.grey,
            PatternState.active => Colors.blue,
            PatternState.success => Colors.green,
            PatternState.error => Colors.red,
          };
          return Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          );
        },
        dotPainter: (_, __, ___) {},
      ),
      child: SizedBox(
        width: 270,
        height: 200,
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
