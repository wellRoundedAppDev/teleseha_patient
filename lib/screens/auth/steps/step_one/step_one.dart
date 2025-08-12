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
              CusomeInput(
                title: 'name'.tr,
                hint: 'name_field'.tr,
                controller: controller.textfieldName,
                showVaildMessage: controller.isVaildName,
                textIsVaild: 'is_vaild_name_field'.tr,
                width_container: 0.90,
                colorLabel: AppColors.colorLineAndText,
                text_input_type: TextInputType.text,
                icon: false,
              ),
              // CusomeInput(
              //   title: 'number_phone'.tr,
              //   hint: 'number_phone_field'.tr,
              //   controller: controller.TextfieldName,
              //   colorLabel: AppColors.colorLabel,
              //   text_input_type: TextInputType.number,
              //   name_icon_field: iconNumber,
              //   fontSize: 16,
              // ),
            ],
          ),
        );
      },
    );
  }
}
