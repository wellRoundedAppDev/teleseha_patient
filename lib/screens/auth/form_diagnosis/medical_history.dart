import '../../../../general_exports.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(
      init: MedicalHistoryController(),
      builder: (MedicalHistoryController controller) {
        return Scaffold(
          appBar: AppBar(),
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
                  SizedBox(height: DEVICE_HEIGHT * 0.08),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: DEVICE_WIDTH * 0.07,
                    ),
                    width: DEVICE_WIDTH,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            text: '1. ',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(AppColors.colorLineAndText),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'do_you_have_any_illnesses'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(AppColors.colorLineAndText),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.035),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: DEVICE_HEIGHT * 0.03,
                            //     vertical: DEVICE_WIDTH * 0.005,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(25),
                            //     border: Border.all(color: Colors.grey.shade300),
                            //   ),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Radio<String>(
                            //         value: 'yes',
                            //         groupValue: controller.selectedOption,
                            //         onChanged: controller.selectOption,
                            //       ),
                            //       const Text(
                            //         'نعم',
                            //         style: TextStyle(fontSize: 13),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(width: DEVICE_WIDTH * 0.1),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: DEVICE_HEIGHT * 0.03,
                            //     vertical: DEVICE_WIDTH * 0.03,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(25),
                            //     border: Border.all(color: Colors.grey.shade300),
                            //   ),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Radio<String>(
                            //         value: 'no',
                            //         groupValue: controller.selectedOption,
                            //         onChanged: controller.selectOption,
                            //       ),
                            //       const Text(
                            //         'لا',
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           color: Color(0xFF005EA2),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            _buildOption(
                              label: 'نعم',
                              value: 'yes',
                              isSelected: controller.selectedOption == 'yes',
                              onTap: () => controller.selectOption('yes'),
                            ),
                            _buildOption(
                              label: 'نعم',
                              value: 'yes',
                              isSelected: controller.selectedOption == 'yes',
                              onTap: () => controller.selectOption('yes'),
                            ),

                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: DEVICE_HEIGHT * 0.03,
                            //     vertical: DEVICE_WIDTH * 0.03,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(25),
                            //     border: Border.all(color: Colors.grey.shade300),
                            //   ),
                            //   child: Row(
                            //     children: <Widget>[
                            //       const Text('test'),
                            //       SizedBox(width: DEVICE_WIDTH * 0.06),
                            //       CustomText(
                            //         text: 'yes'.tr,
                            //         fontSize: 10,
                            //         type: CustomTextType.title,
                            //         color: const Color(
                            //           AppColors.colorSelectDropDown,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(width: DEVICE_WIDTH * 0.1),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: DEVICE_HEIGHT * 0.03,
                            //     vertical: DEVICE_WIDTH * 0.03,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(25),
                            //     border: Border.all(color: Colors.grey.shade300),
                            //   ),
                            //   child: Row(
                            //     children: <Widget>[
                            //       const Text('test'),
                            //       SizedBox(width: DEVICE_WIDTH * 0.06),
                            //       CustomText(
                            //         text: 'no'.tr,
                            //         fontSize: 10,
                            //         type: CustomTextType.title,
                            //         color: const Color(
                            //           AppColors.colorSelectDropDown,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Btn(
                  //   text: 'next'.tr,
                  //   color: const Color(AppColors.colorLineAndText),
                  //   onPressed: () {
                  //     controller.dedicalHistory()
                  //         ? Get.to(CustomOtp())
                  //         : const SizedBox();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildOption({
  required String label,
  required String value,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          // ✅ دائرة الاختيار المخصصة
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),

          const SizedBox(width: 10),

          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
