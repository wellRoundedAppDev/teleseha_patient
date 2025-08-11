import '../../general_exports.dart';

class CusomeAllFormHistory extends StatelessWidget {
  const CusomeAllFormHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return Column(
          children: [
            Text(
              'medical_history'.tr,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.colorTextBlue),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.04),
            // CusomeForm(
            //   title: 'chronic_diseases'.tr,
            //   hintText: 'create_chronic_diseases'.tr,
            //   controller: controller.TextfieldChronicDiseases,
            //   isVaild: controller.isVaildChronicDiseases,
            //   textIsVaild: 'is_vaild_diseases'.tr,
            //   key: null,
            // AppColors.colorLabel
            // width_container: 0.85
            // ),
            // CusomeForm(
            //   title: 'surgical_operations'.tr,
            //   hintText: 'create_surgical_operations'.tr,
            //   controller: controller.TextfieldSurgicalOperations,
            //   isVaild: controller.isVaildSurgicalOperations,
            //   textIsVaild: 'is_vaild_surgical_operations'.tr,
            //   key: null,
            // ),
            // CusomeForm(
            //   title: 'continuous_medications'.tr,
            //   hintText: 'create_continuous_medications'.tr,
            //   controller: controller.TextfieldContinuousMedications,
            //   isVaild: controller.isVaildContinuousMedications,
            //   textIsVaild: 'is_vaild_continuous_medications'.tr,
            //   key: null,
            // ),
            // CusomeForm(
            //   title: 'allergies'.tr,
            //   hintText: 'create_allergies'.tr,
            //   controller: controller.TextfieldAllergies,
            //   isVaild: controller.isVaildAllergies,
            //   textIsVaild: 'is_vaild_allergies'.tr,
            //   key: null,
            // ),
          ],
        );
      },
    );
  }
}
