import '../../../../general_exports.dart';

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(
      init: MedicalHistoryController(),
      builder: (MedicalHistoryController controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.07),
              child: Column(
                children: <Widget>[
                  SizedBox(height: DEVICE_HEIGHT * 0.1),
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                  CustomText(
                    text: 'medical_history'.tr,
                    fontSize: 24,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.08),
                  Column(
                    children: controller.visibleQuestions.map((
                      QuestionModel q,
                    ) {
                      final bool isMainQuestion = q.id == 'chronic';
                      return Padding(
                        padding: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.035),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                if (isMainQuestion)
                                  const Text(
                                    '1.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (!isMainQuestion)
                                  Container(
                                    margin: const EdgeInsets.only(top: 2.8),
                                    width: DEVICE_WIDTH * 0.013,
                                    height: DEVICE_HEIGHT * 0.007,
                                    color: const Color(AppColors.colorLabel),
                                  ),
                                SizedBox(width: DEVICE_WIDTH * 0.03),
                                CustomText(
                                  text: q.questionText,
                                  fontSize: 16,
                                  type: CustomTextType.title,
                                  color: const Color(AppColors.colorLabel),
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),

                            if (q.type == QuestionType.radio)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _buildOption(
                                    label: 'نعم',
                                    value: 'yes',
                                    isSelected: q.selectedAnswer == 'yes',
                                    onTap: () => controller.selectRadioAnswer(
                                      q.id,
                                      'yes',
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.1),
                                  _buildOption(
                                    label: 'لا',
                                    value: 'no',
                                    isSelected: q.selectedAnswer == 'no',
                                    onTap: () => controller.selectRadioAnswer(
                                      q.id,
                                      'no',
                                    ),
                                  ),
                                ],
                              ),
                            if (q.type == QuestionType.checkboxList)
                              Column(
                                children: q.checkboxOptions!.map((
                                  String option,
                                ) {
                                  final bool isChecked = q
                                      .selectedCheckboxAnswers
                                      .contains(option);
                                  return GestureDetector(
                                    onTap: () => controller
                                        .toggleCheckboxAnswer(q.id, option),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: DEVICE_WIDTH * 0.06,
                                            height: DEVICE_WIDTH * 0.06,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isChecked
                                                  ? const Color(
                                                      AppColors
                                                          .colorLineAndText,
                                                    )
                                                  : Colors.white,
                                              border: Border.all(
                                                color: isChecked
                                                    ? const Color(
                                                        AppColors
                                                            .colorLineAndText,
                                                      )
                                                    : Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                            child: isChecked
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 16,
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 10),
                                          CustomText(
                                            text: option,
                                            fontSize: 10,
                                            type: CustomTextType.title,
                                            color: const Color(
                                              AppColors.colorTextBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.05),
                  Column(
                    children: <Widget>[
                      StepIndicator(
                        currentStep: controller.currentStep,
                        totalSteps: controller.numberOfStep,
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.052),
                      Btn(
                        text: 'next'.tr,
                        onPressed: controller.hasAnyAnswer
                            ? () {
                                controller.goToNextStep();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.hasAnyAnswer
                              ? const Color(AppColors.colorLineAndText)
                              : const Color.fromARGB(83, 0, 123, 189),
                          padding: EdgeInsets.symmetric(
                            vertical: DEVICE_HEIGHT * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.11),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: DEVICE_WIDTH * 0.09,
              height: DEVICE_HEIGHT * 0.03,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(AppColors.colorLineAndText)
                    : const Color(AppColors.colorWhiteSelectedType),
                border: Border.all(
                  color: isSelected
                      ? const Color(AppColors.colorLineAndText)
                      : Colors.grey,
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
}
