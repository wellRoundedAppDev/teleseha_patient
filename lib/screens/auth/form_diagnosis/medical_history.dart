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
                  if (controller.isLoading)
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.4,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else
                    controller.questions.isEmpty
                        ? SizedBox(
                            height: DEVICE_HEIGHT * 0.4,
                            child: const Center(child: Text('لا توجد بيانات')),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.questions.length,
                            itemBuilder: (BuildContext context, int index) {
                              // ignore: always_specify_types
                              final section = controller.questions[index];

                              if (index != controller.currentStep - 1) {
                                return const SizedBox();
                              }

                              final bool showSubSections =
                                  section['showSubSections'] ?? false;

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: DEVICE_HEIGHT * 0.035,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CustomText(
                                          text: '${index + 1}. ',
                                          fontSize: 16,
                                          type: CustomTextType.title,
                                          color: const Color(
                                            AppColors.colorLineAndText,
                                          ),
                                        ),
                                        SizedBox(width: DEVICE_WIDTH * 0.03),
                                        Expanded(
                                          child: CustomText(
                                            text: section['question'] ?? '',
                                            fontSize: 16,
                                            type: CustomTextType.title,
                                            color: const Color(
                                              AppColors.colorLineAndText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        _buildOption(
                                          label: 'نعم',
                                          value: 'yes',
                                          isSelected:
                                              section['isSelected'] == true,
                                          onTap: () {
                                            section['isSelected'] = true;
                                            section['showSubSections'] = true;
                                            controller.update();
                                          },
                                        ),
                                        SizedBox(width: DEVICE_WIDTH * 0.1),
                                        _buildOption(
                                          label: 'لا',
                                          value: 'no',
                                          isSelected:
                                              section['isSelected'] == false,
                                          onTap: () {
                                            section['isSelected'] = false;
                                            section['showSubSections'] = false;
                                            controller.update();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                                    if (showSubSections &&
                                        section['subSection'] != null)
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: section['subSection'].length,
                                        itemBuilder: (BuildContext context, int subIndex) {
                                          // ignore: always_specify_types
                                          final subItem =
                                              section['subSection'][subIndex];
                                          return Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                          top: 2.8,
                                                        ),
                                                    width: DEVICE_WIDTH * 0.013,
                                                    height:
                                                        DEVICE_HEIGHT * 0.007,
                                                    color: const Color(
                                                      AppColors.colorLabel,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: DEVICE_WIDTH * 0.03,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        subItem['subSectionName'],
                                                    fontSize: 16,
                                                    type: CustomTextType.title,
                                                    color: const Color(
                                                      AppColors.colorLabel,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: DEVICE_HEIGHT * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _buildOption(
                                                    label: 'نعم',
                                                    value: 'yes',
                                                    isSelected:
                                                        subItem['isSelected'] ==
                                                        true, // مستقل لكل subSection
                                                    onTap: () {
                                                      subItem['isSelected'] =
                                                          true; // فقط هذا الـ subSection
                                                      subItem['showItems'] =
                                                          true; // لإظهار الـ items
                                                      controller.update();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: DEVICE_WIDTH * 0.1,
                                                  ),
                                                  _buildOption(
                                                    label: 'لا',
                                                    value: 'no',
                                                    isSelected:
                                                        subItem['isSelected'] ==
                                                        false, // مستقل لكل subSection
                                                    onTap: () {
                                                      subItem['isSelected'] =
                                                          false;
                                                      subItem['showItems'] =
                                                          false;
                                                      controller.update();
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: DEVICE_HEIGHT * 0.02,
                                              ),
                                              if (subItem['showItems'] ==
                                                      true &&
                                                  subItem['items'] != null)
                                                Column(
                                                  children: subItem['items'].map<Widget>((
                                                    // ignore: always_specify_types
                                                    item,
                                                  ) {
                                                    item['isSelected'] =
                                                        item['isSelected'];
                                                    final bool isSelected =
                                                        item['isSelected'] ??
                                                        false;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        item['isSelected'] =
                                                            !isSelected;
                                                        controller.update();
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                                DEVICE_WIDTH *
                                                                0.85,
                                                            margin:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 6,
                                                                ),
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    25,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width:
                                                                      DEVICE_WIDTH *
                                                                      0.06,
                                                                  height:
                                                                      DEVICE_WIDTH *
                                                                      0.06,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        isSelected
                                                                        ? const Color(
                                                                            AppColors.colorLineAndText,
                                                                          )
                                                                        : Colors
                                                                              .white,
                                                                    border: Border.all(
                                                                      color:
                                                                          isSelected
                                                                          ? const Color(
                                                                              AppColors.colorLineAndText,
                                                                            )
                                                                          : Colors.grey,
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      isSelected
                                                                      ? const Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              16,
                                                                        )
                                                                      : null,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      item['itemName'],
                                                                  fontSize: 10,
                                                                  type:
                                                                      CustomTextType
                                                                          .title,
                                                                  color: const Color(
                                                                    AppColors
                                                                        .colorTextBlue,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              SizedBox(
                                                height: DEVICE_HEIGHT * 0.02,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                  // else
                  //   controller.questions.isEmpty
                  //       ? SizedBox(
                  //           height: DEVICE_HEIGHT * 0.4,
                  //           child: const Center(child: Text('لا توجد بيانات')),
                  //         )
                  //       : Column(
                  //           children: <Widget>[
                  //             SizedBox(
                  //               height: DEVICE_HEIGHT * 0.18,
                  //               child: Padding(
                  //                 padding: EdgeInsets.only(
                  //                   bottom: DEVICE_HEIGHT * 0.035,
                  //                 ),
                  //                 child: ListView.builder(
                  //                   padding: EdgeInsets.zero,
                  //                   shrinkWrap: true,
                  //                   physics:
                  //                       const NeverScrollableScrollPhysics(),
                  //                   itemCount: controller.questions.length,
                  //                   itemBuilder: (BuildContext context, int index) {
                  //                     final question =
                  //                         controller.questions[index];

                  //                     return Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: <Widget>[
                  //                         // السؤال الرئيسي
                  //                         Row(
                  //                           children: <Widget>[
                  //                             CustomText(
                  //                               text: '${index + 1}. ',
                  //                               fontSize: 16,
                  //                               type: CustomTextType.title,
                  //                               color: const Color(
                  //                                 AppColors.colorLineAndText,
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: DEVICE_WIDTH * 0.03,
                  //                             ),
                  //                             Expanded(
                  //                               child: CustomText(
                  //                                 text:
                  //                                     question['question'] ??
                  //                                     '',
                  //                                 fontSize: 16,
                  //                                 type: CustomTextType.title,
                  //                                 color: const Color(
                  //                                   AppColors.colorLineAndText,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: DEVICE_HEIGHT * 0.02,
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: <Widget>[
                  //                             _buildOption(
                  //                               label: 'نعم',
                  //                               value: 'yes',
                  //                               isSelected:
                  //                                   question['isSelected'] ==
                  //                                   true,
                  //                               onTap: () async {
                  //                                 question['isSelected'] = true;
                  //                                 controller.update();
                  //                                 await controller.sendAnswer(
                  //                                   controller.currentStep,
                  //                                   question['sectionId'],
                  //                                   'yes',
                  //                                 );
                  //                               },
                  //                             ),
                  //                             SizedBox(
                  //                               width: DEVICE_WIDTH * 0.1,
                  //                             ),
                  //                             _buildOption(
                  //                               label: 'لا',
                  //                               value: 'no',
                  //                               isSelected:
                  //                                   question['isSelected'] ==
                  //                                   false,
                  //                               onTap: () async {
                  //                                 question['isSelected'] =
                  //                                     false;
                  //                                 controller.update();
                  //                                 await controller.sendAnswer(
                  //                                   controller.currentStep,
                  //                                   question['sectionId'],
                  //                                   'no',
                  //                                 );
                  //                               },
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: DEVICE_HEIGHT * 0.02,
                  //                         ),
                  //                         SizedBox(
                  //                           height: DEVICE_HEIGHT * 0.6,
                  //                           child: ListView.builder(
                  //                             shrinkWrap: true,
                  //                             physics:
                  //                                 const AlwaysScrollableScrollPhysics(),
                  //                             padding: EdgeInsets.zero,
                  //                             itemCount:
                  //                                 controller.questions.length,
                  //                             itemBuilder:
                  //                                 (
                  //                                   BuildContext context,
                  //                                   int index,
                  //                                 ) {
                  //                                   // ignore: always_specify_types
                  //                                   final question = controller
                  //                                       .questions[index];
                  //                                   return Padding(
                  //                                     padding:
                  //                                         EdgeInsets.symmetric(
                  //                                           vertical:
                  //                                               DEVICE_HEIGHT *
                  //                                               0.01,
                  //                                           horizontal:
                  //                                               DEVICE_WIDTH *
                  //                                               0.03,
                  //                                         ),
                  //                                     child: Container(
                  //                                       padding:
                  //                                           const EdgeInsets.all(
                  //                                             12,
                  //                                           ),
                  //                                       decoration: BoxDecoration(
                  //                                         color: Colors.white,
                  //                                         borderRadius:
                  //                                             BorderRadius.circular(
                  //                                               8,
                  //                                             ),
                  //                                         border: Border.all(
                  //                                           color: Colors
                  //                                               .grey
                  //                                               .shade300,
                  //                                         ),
                  //                                       ),
                  //                                       child: Text(
                  //                                         question['question'] ??
                  //                                             'test',
                  //                                         style:
                  //                                             const TextStyle(
                  //                                               fontSize: 16,
                  //                                               color: Colors
                  //                                                   .black,
                  //                                             ),
                  //                                       ),
                  //                                     ),
                  //                                   );
                  //                                 },
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  // Column(
                  //   children: controller.visibleQuestions.map((
                  //     QuestionModel q,
                  //   ) {
                  //     final bool isMainQuestion = q.id == 'chronic';
                  //     return Padding(
                  //       padding: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.035),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Row(
                  //             children: <Widget>[
                  //               if (isMainQuestion)
                  //                 const CustomText(
                  //                   text: '1.',
                  //                   fontSize: 16,
                  //                   type: CustomTextType.title,
                  //                   color: Color(AppColors.colorLineAndText),
                  //                 ),
                  //               if (!isMainQuestion)
                  //                 Container(
                  //                   margin: const EdgeInsets.only(top: 2.8),
                  //                   width: DEVICE_WIDTH * 0.013,
                  //                   height: DEVICE_HEIGHT * 0.007,
                  //                   color: const Color(AppColors.colorLabel),
                  //                 ),
                  //               SizedBox(width: DEVICE_WIDTH * 0.03),
                  //               CustomText(
                  //                 text: q.questionText,
                  //                 fontSize: 16,
                  //                 type: CustomTextType.title,
                  //                 color: const Color(
                  //                   AppColors.colorLineAndText,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: DEVICE_HEIGHT * 0.02),
                  //           if (q.type == QuestionType.radio)
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: <Widget>[
                  //                 _buildOption(
                  //                   label: 'نعم',
                  //                   value: 'yes',
                  //                   isSelected: q.selectedAnswer == 'yes',
                  //                   onTap: () => controller.selectRadioAnswer(
                  //                     q.id,
                  //                     'yes',
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: DEVICE_WIDTH * 0.1),
                  //                 _buildOption(
                  //                   label: 'لا',
                  //                   value: 'no',
                  //                   isSelected: q.selectedAnswer == 'no',
                  //                   onTap: () => controller.selectRadioAnswer(
                  //                     q.id,
                  //                     'no',
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           if (q.type == QuestionType.checkboxList)
                  //             Column(
                  //               children: q.checkboxOptions!.map((
                  //                 String option,
                  //               ) {
                  //                 final bool isChecked = q
                  //                     .selectedCheckboxAnswers
                  //                     .contains(option);
                  //                 return GestureDetector(
                  //                   onTap: () => controller
                  //                       .toggleCheckboxAnswer(q.id, option),
                  //                   child: Container(
                  //                     margin: const EdgeInsets.symmetric(
                  //                       vertical: 6,
                  //                     ),
                  //                     padding: const EdgeInsets.symmetric(
                  //                       horizontal: 22,
                  //                       vertical: 12,
                  //                     ),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(25),
                  //                       border: Border.all(
                  //                         color: Colors.grey.shade300,
                  //                       ),
                  //                       color: Colors.white,
                  //                     ),
                  //                     child: Row(
                  //                       children: <Widget>[
                  //                         Container(
                  //                           width: DEVICE_WIDTH * 0.06,
                  //                           height: DEVICE_WIDTH * 0.06,
                  //                           decoration: BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color: isChecked
                  //                                 ? const Color(
                  //                                     AppColors
                  //                                         .colorLineAndText,
                  //                                   )
                  //                                 : Colors.white,
                  //                             border: Border.all(
                  //                               color: isChecked
                  //                                   ? const Color(
                  //                                       AppColors
                  //                                           .colorLineAndText,
                  //                                     )
                  //                                   : Colors.grey,
                  //                               width: 2,
                  //                             ),
                  //                           ),
                  //                           child: isChecked
                  //                               ? const Icon(
                  //                                   Icons.check,
                  //                                   color: Colors.white,
                  //                                   size: 16,
                  //                                 )
                  //                               : null,
                  //                         ),
                  //                         const SizedBox(width: 10),
                  //                         CustomText(
                  //                           text: option,
                  //                           fontSize: 10,
                  //                           type: CustomTextType.title,
                  //                           color: const Color(
                  //                             AppColors.colorTextBlue,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //         ],
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
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
                        onPressed: controller.hasSelectedAnswer
                            ? () {
                                controller.nextStep();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.hasSelectedAnswer
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
