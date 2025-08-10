import '../../../../general_exports.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return CusomeAllFormHistory();
      },
    );
  }
}
