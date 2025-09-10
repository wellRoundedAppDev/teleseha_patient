import '../../general_exports.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: DEVICE_HEIGHT * 0.01,
      runSpacing: DEVICE_HEIGHT * 0.02,
      children: List.generate(totalSteps, (int index) {
        final int stepNumber = totalSteps - index;
        return ContainerSteps(alpha: currentStep == stepNumber ? 250 : 80);
      }),
    );
  }
}
