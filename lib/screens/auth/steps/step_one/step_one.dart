import '../../../../general_exports.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (StartStepsController controller) {
        return Container(
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomInput(
                title: 'number_phone'.tr,
                hint: 'number_phone_field'.tr,
                controller: controller.textFieldPhoneNumber,
                showValidMessage: controller.showPhoneNumberError,
                textIsValid: 'is_valid_number'.tr,
                widthContainer: 0.90,
                colorLabel: AppColors.colorLineAndText,
                keyboardType: TextInputType.number,
                suffixIconPath: iconNumber,
              ),
            ],
          ),
        );
      },
    );
  }
}
