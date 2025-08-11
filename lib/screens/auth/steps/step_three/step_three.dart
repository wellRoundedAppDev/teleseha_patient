import '../../../../general_exports.dart';

class StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            CusomeForm(
              title: 'name'.tr,
              hintText: 'name_field'.tr,
              controller: controller.TextfieldName,
              isVaild: controller.isVaildName,
              textIsVaild: 'is_vaild_name_field'.tr,
              key: null,
              colorLabel: AppColors.colorLabel,
              text_input_type: TextInputType.text,
              name_icon_field: iconUserName,
            ),
            CusomeForm(
              title: 'number_phone'.tr,
              hintText: 'number_phone_field'.tr,
              controller: controller.TextfieldNumber,
              isVaild: controller.isVaildNumber,
              textIsVaild: 'is_vaild_number'.tr,
              key: null,
              colorLabel: AppColors.colorLabel,
              text_input_type: TextInputType.number,
              name_icon_field: iconNumber,
            ),
          ],
        );
      },
    );
  }
}
