import '../../general_exports.dart';

class ContainerSteps extends StatelessWidget {
  ContainerSteps({super.key, required this.MyAlpha});

  double MyAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue.withValues(alpha: MyAlpha)),
      width: DEVICE_WIDTH * 0.09,
      height: DEVICE_HEIGHT * 0.004,
    );
  }
}
