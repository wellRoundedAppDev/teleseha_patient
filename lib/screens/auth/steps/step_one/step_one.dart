import '../../../../general_exports.dart';

class StepOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomeInput(
                title: 'number_phone'.tr,
                hint: 'number_phone_field'.tr,
                controller: controller.textFieldPhoneNumber,
                showVaildMessage: controller.showPhoneNumberError,
                textIsVaild: 'is_vaild_number'.tr,
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
