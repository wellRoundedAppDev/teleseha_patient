import '../../general_exports.dart';

class ContainerSteps extends StatelessWidget {
  ContainerSteps({super.key, this.myAlpha});

  final int? myAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(AppColors.colorLineAndText).withAlpha(myAlpha!),
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
      ),
      width: DEVICE_WIDTH * 0.07,
      height: DEVICE_HEIGHT * 0.006,
    );
  }
}
