import '../../../../general_exports.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (StartStepsController controller) {
        return Column(
          children: <Widget>[
            Text(
              'login'.tr,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.colorTextBlue),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.1),
            CustomInput(
              title: 'number_phone'.tr,
              hint: 'number_phone_field'.tr,
              controller: controller.textFieldPhoneNumber,
              showValidMessage: controller.showPhoneNumberError,
              textIsValid: 'is_valid_number'.tr,
              widthContainer: 0.90,
              colorLabel: AppColors.colorLabel,
              keyboardType: TextInputType.number,
              suffixIconPath: iconNumber,
            ),
          ],
        );
      },
    );
  }
}
