import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentProfileDoctor extends StatelessWidget {
  const ContentProfileDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        final int? selectedDoctorId = controller.passedIndex;

        Map<String, dynamic>? selectedDoctor;
        selectedDoctor = controller.doctors.firstWhere(
          (Map<String, dynamic> doctor) => doctor['id'] == selectedDoctorId,
          orElse: () => <String, dynamic>{},
        );

        final List<Map<String, String>> availableTimes =
            selectedDoctor['available_times'] as List<Map<String, String>>;

        return SizedBox(
          height: DEVICE_HEIGHT,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: DEVICE_HEIGHT * 0.03),
                      CustomText(
                        text: selectedDoctor['name'],
                        fontSize: 24,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorBlack),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.014),
                      CustomText(
                        text: 'general_specialization_with_minor'.tr,
                        fontSize: 12,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorLineAndText),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.014),
                      Row(
                        children: <Widget>[
                          CustomText(
                            text: selectedDoctor['range'],
                            fontSize: 12,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorBlack),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.012),
                          SvgPicture.asset(
                            iconStar,
                            width: DEVICE_WIDTH * 0.025,
                            height: DEVICE_HEIGHT * 0.015,
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.025),
                          CustomText(
                            text: selectedDoctor['reveal'],
                            fontSize: 11,
                            type: CustomTextType.inputTitle,
                            color: const Color(
                              AppColors.colorNameSpecialization,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.025),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomText(
                            text: 'about_doctor'.tr,
                            fontSize: 14,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorAboutDoctor),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.006),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(AppColors.colorNameSpecialization),
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: selectedDoctor['descriptionDoctor']
                                      .replaceAll('\n', '\n'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.012),
                Container(
                  height: DEVICE_HEIGHT * 0.001,
                  width: DEVICE_WIDTH,
                  color: const Color.fromARGB(78, 128, 128, 31),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.013),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: 'data'.tr,
                        fontSize: 14,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorAboutDoctor),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.012),
                      Container(
                        width: DEVICE_WIDTH,
                        padding: EdgeInsets.all(DEVICE_HEIGHT * 0.025),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(AppColors.colorWhiteSelectedType),
                          border: Border.all(
                            color: const Color(
                              AppColors.colorBorderDataDoctor,
                            ).withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      iconMap,
                                      width: DEVICE_WIDTH * 0.018,
                                      height: DEVICE_HEIGHT * 0.018,
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.015),
                                    CustomText(
                                      text: 'address'.tr,
                                      fontSize: 13,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.015),
                                CustomText(
                                  text: selectedDoctor['address'],
                                  fontSize: 14,
                                  type: CustomTextType.button,
                                  color: const Color(
                                    AppColors.colorNameSpecialization,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.028),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      iconDate,
                                      width: DEVICE_WIDTH * 0.015,
                                      height: DEVICE_HEIGHT * 0.015,
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.015),
                                    CustomText(
                                      text: 'available_time'.tr,
                                      fontSize: 13,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.015),
                                SizedBox(
                                  width: DEVICE_WIDTH * 0.3,
                                  child: Wrap(
                                    spacing: DEVICE_WIDTH * 0.01,
                                    runSpacing: DEVICE_HEIGHT * 0.01,
                                    children: availableTimes
                                        .fold<Map<String, List<String>>>({}, (
                                          acc,
                                          time,
                                        ) {
                                          final day = time['day']!;
                                          final timeSlot = time['time']!;
                                          if (!acc.containsKey(day)) {
                                            acc[day] = [];
                                          }
                                          acc[day]!.add(timeSlot);
                                          return acc;
                                        })
                                        .entries
                                        .map((entry) {
                                          final day = entry.key;
                                          final timeSlots = entry.value;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              CustomText(
                                                text: day,
                                                fontSize: 13,
                                                type: CustomTextType.title,
                                                color: const Color(
                                                  AppColors
                                                      .colorNameSpecialization,
                                                ),
                                              ),
                                              for (var time in timeSlots)
                                                CustomText(
                                                  text: time,
                                                  fontSize: 13,
                                                  type: CustomTextType.title,
                                                  color: const Color(
                                                    AppColors
                                                        .colorNameSpecialization,
                                                  ),
                                                ),
                                            ],
                                          );
                                        })
                                        .toList(),
                                  ),
                                ),
                                // SizedBox(
                                //   width: DEVICE_WIDTH * 0.3,
                                //   child: Wrap(
                                //     spacing: DEVICE_WIDTH * 0.01,
                                //     runSpacing: DEVICE_HEIGHT * 0.01,
                                //     children: availableTimes.asMap().entries.map((
                                //       MapEntry<int, Map<String, String>> entry,
                                //     ) {
                                //       final int index = entry.key;
                                //       final Map<String, String> time =
                                //           entry.value;
                                //       final bool isOddIndex = index % 2 != 0;
                                //       return Column(
                                //         children: <Widget>[
                                //           CustomText(
                                //             text:
                                //                 '${time['day']!}${isOddIndex ? '' : ' - '}',
                                //             fontSize: 13,
                                //             type: CustomTextType.title,
                                //             color: const Color(
                                //               AppColors.colorNameSpecialization,
                                //             ),
                                //           ),
                                //           CustomText(
                                //             text:
                                //                 '${time['day']!}${isOddIndex ? '' : ' - '}',
                                //             fontSize: 13,
                                //             type: CustomTextType.title,
                                //             color: const Color(
                                //               AppColors.colorNameSpecialization,
                                //             ),
                                //           ),
                                //         ],
                                //       );
                                //     }).toList(),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
