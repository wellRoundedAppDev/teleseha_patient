import '../../general_exports.dart';

class ContainerSteps extends StatelessWidget {
  ContainerSteps({super.key, required this.MyAlpha});

  final int MyAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(AppColors.colorLineAndText).withAlpha(MyAlpha),
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
      ),
      width: DEVICE_WIDTH * 0.07,
      height: DEVICE_HEIGHT * 0.006,
    );
  }
}
