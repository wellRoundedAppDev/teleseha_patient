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
              title: 'number_phone'.tr,
              hintText: 'number_phone_field'.tr,
              controller: controller.TextfieldNumber,
              isVaild: controller.isVaildNumber,
              textIsVaild: 'is_vaild_number'.tr,
              key: null,
              colorLabel: AppColors.colorLabel,
              text_input_type: TextInputType.number,
              name_icon_field: iconNumber,
              fontSize: 16,
            ),
            CusomeForm(
              title: 'password'.tr,
              hintText: 'number_phone_field'.tr,              
              controller: controller.TextfieldPassword,
              isVaild: controller.isVaildPassword,
              textIsVaild: 'is_vaild_number'.tr,
              key: null,
              colorLabel: AppColors.colorLabel,
              text_input_type: TextInputType.visiblePassword,
              icon: false,
              fontSize: 16,
            ),
          ],
        );
      },
    );
  }
}
