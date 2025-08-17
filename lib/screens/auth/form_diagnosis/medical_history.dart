import 'package:flutter_svg/flutter_svg.dart';

import '../../../../general_exports.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiagnosisRecipientController>(
      init: DiagnosisRecipientController(),
      builder: (DiagnosisRecipientController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    controller.clearAllFields();
                    Get.back();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      iconBack,
                      width: DEVICE_WIDTH * 0.04,
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: DEVICE_WIDTH * 0.035),
                    child: TextButton(
                      onPressed: () {
                        Get.to(CustomOtp());
                      },
                      child: CustomText(
                        text: 'skep'.tr,
                        type: CustomTextType.title,
                        fontSize: 10,
                        color: const Color(AppColors.colorBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: DEVICE_WIDTH,
              child: Column(
                children: <Widget>[
                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                  CustomText(
                    text: 'medical_history'.tr,
                    fontSize: 24,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.05),
                  CustomInput(
                    title: 'chronic_diseases'.tr,
                    hint: 'create_chronic_diseases'.tr,
                    controller: controller.textfieldChronicDiseases,
                    showValidMessage: controller.showChronicDiseases,
                    textIsValid: 'is_valid_diseases'.tr,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                    sizespace: 0.005,
                  ),
                  CustomInput(
                    title: 'surgical_operations'.tr,
                    hint: 'create_surgical_operations'.tr,
                    controller: controller.textfieldSurgicalOperations,
                    showValidMessage: controller.showSurgicalOperations,
                    textIsValid: 'is_valid_surgical_operations'.tr,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                    sizespace: 0.005,
                  ),
                  CustomInput(
                    title: 'continuous_medications'.tr,
                    hint: 'create_continuous_medications'.tr,
                    controller: controller.textfieldContinuousMedications,
                    showValidMessage: controller.showContinuousMedications,
                    textIsValid: 'is_valid_continuous_medications'.tr,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                    sizespace: 0.005,
                  ),
                  CustomInput(
                    title: 'allergies'.tr,
                    hint: 'create_allergies'.tr,
                    controller: controller.textfieldAllergies,
                    showValidMessage: controller.showAllergies,
                    textIsValid: 'is_valid_allergies'.tr,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                    sizespace: 0.005,
                    bottomSpacing: 0.058,
                  ),
                  Btn(
                    text: 'next'.tr,
                    color: const Color(AppColors.colorLineAndText),
                    onPressed: () {
                      controller.dedicalHistory()
                          ? Get.to(CustomOtp())
                          : const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
