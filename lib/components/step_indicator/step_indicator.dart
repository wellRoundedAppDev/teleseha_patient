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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: always_specify_types
      children: List.generate(totalSteps, (int index) {
        final int stepNumber = totalSteps - index;
        return Row(
          children: <Widget>[
            ContainerSteps(alpha: currentStep == stepNumber ? 250 : 80),
            if (index != totalSteps - 1) SizedBox(width: DEVICE_HEIGHT * 0.01),
          ],
        );
      }),
    );
  }
}
