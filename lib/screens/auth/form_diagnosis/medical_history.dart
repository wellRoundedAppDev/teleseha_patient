import '../../../../general_exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiagnsisRecipientController>(
      init: DiagnsisRecipientController(),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
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
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: DEVICE_WIDTH,
              child: Column(
                children: [
                  controller.isMyChildrenSelected == 'aboutMe'
                      ? Text(
                          'medical_history'.tr,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(AppColors.colorTextBlue),
                          ),
                        )
                      : Text(
                          'medical_history_about_children'.tr,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(AppColors.colorTextBlue),
                          ),
                        ),
                  SizedBox(height: DEVICE_HEIGHT * 0.05),
                  CustomeInput(
                    title: 'chronic_diseases'.tr,
                    hint: 'create_chronic_diseases'.tr,
                    controller: controller.textfieldChronicDiseases,
                    showVaildMessage: controller.showChronicDiseases,
                    textIsVaild: 'is_vaild_diseases'.tr,
                    key: null,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                  ),
                  CustomeInput(
                    title: 'surgical_operations'.tr,
                    hint: 'create_surgical_operations'.tr,
                    controller: controller.textfieldSurgicalOperations,
                    showVaildMessage: controller.showSurgicalOperations,
                    textIsVaild: 'is_vaild_surgical_operations'.tr,
                    key: null,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                  ),
                  CustomeInput(
                    title: 'continuous_medications'.tr,
                    hint: 'create_continuous_medications'.tr,
                    controller: controller.textfieldContinuousMedications,
                    showVaildMessage: controller.showContinuousMedications,
                    textIsVaild: 'is_vaild_continuous_medications'.tr,
                    key: null,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                  ),
                  CustomeInput(
                    title: 'allergies'.tr,
                    hint: 'create_allergies'.tr,
                    controller: controller.textfieldAllergies,
                    showVaildMessage: controller.showAllergies,
                    textIsVaild: 'is_vaild_allergies'.tr,
                    key: null,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.number,
                    fontSize: 16,
                  ),
                  Btn(
                    text: 'next'.tr,
                    color: Color(AppColors.colorLineAndText),
                    onPressed: () {
                      controller.dedical_history()
                          ? Get.toNamed(routeAuth)
                          : '';
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
