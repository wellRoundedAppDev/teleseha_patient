import '../../general_exports.dart';

class ContainerSteps extends StatelessWidget {
  const ContainerSteps({super.key, this.alpha});

  final int? alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.colorLineAndText).withAlpha(alpha!),
        borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
      ),
      width: DEVICE_WIDTH * 0.07,
      height: DEVICE_HEIGHT * 0.006,
    );
  }
}
