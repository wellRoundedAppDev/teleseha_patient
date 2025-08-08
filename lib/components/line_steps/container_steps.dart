import '../../general_exports.dart';

class ContainerSteps extends StatelessWidget {
  ContainerSteps({super.key, required this.MyAlpha});

  double MyAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: MyAlpha),
        // borderRadius: borderRadius.circular(20),
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
      ),
      width: DEVICE_WIDTH * 0.07,
      height: DEVICE_HEIGHT * 0.006,
    );
  }
}
