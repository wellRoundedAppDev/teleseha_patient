import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentProfileDoctor extends StatelessWidget {
  const ContentProfileDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        controller.selectedDoctorFunction();

        // final availableTimes = controller.selectedDoctor?['available_times'];
        // final qualifications = controller.selectedDoctor?['qualifications'];

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
                        text: controller.selectedDoctor?['name'],
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
                            text: controller.selectedDoctor?['range'],
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
                            text: controller.selectedDoctor?['reveal'],
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
                                  text: controller
                                      .selectedDoctor?['descriptionDoctor']
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
                                  text: controller.selectedDoctor?['address'],
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
                                      width: DEVICE_WIDTH * 0.017,
                                      height: DEVICE_HEIGHT * 0.017,
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.015),
                                    CustomText(
                                      text: 'available_time'.tr,
                                      fontSize: 14,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.011),
                                SizedBox(
                                  width: DEVICE_WIDTH * 0.47,
                                  child: Wrap(
                                    runSpacing: DEVICE_HEIGHT * 0.01,
                                    children:
                                        (controller.availableTimes
                                                as List<Map<String, dynamic>>)
                                            .map<Widget>((
                                              Map<String, dynamic> time,
                                            ) {
                                              final List<String> days =
                                                  time['days'] as List<String>;
                                              final List times =
                                                  time['times'] as List;
                                              final String displayDays = days
                                                  .join(' - ');
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  CustomText(
                                                    text: displayDays,
                                                    fontSize: 14,
                                                    type: CustomTextType.title,
                                                    color: const Color.fromARGB(
                                                      255,
                                                      86,
                                                      93,
                                                      99,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        DEVICE_HEIGHT * 0.0027,
                                                  ),
                                                  ...times.map<Widget>((
                                                    timeItem,
                                                  ) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                        right:
                                                            DEVICE_WIDTH *
                                                            0.015,
                                                        bottom:
                                                            DEVICE_HEIGHT *
                                                            0.002,
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                                DEVICE_WIDTH *
                                                                0.01,
                                                            height:
                                                                DEVICE_HEIGHT *
                                                                0.005,
                                                            color: const Color(
                                                              AppColors
                                                                  .colorNameSpecialization,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                DEVICE_WIDTH *
                                                                0.0122,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                timeItem['time']!,
                                                            fontSize: 12,
                                                            type: CustomTextType
                                                                .title,
                                                            color: const Color(
                                                              AppColors
                                                                  .colorNameSpecialization,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              );
                                            })
                                            .toList(),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: DEVICE_HEIGHT * 0.028),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     Row(
                            //       children: <Widget>[
                            //         SvgPicture.asset(
                            //           iconDate,
                            //           width: DEVICE_WIDTH * 0.017,
                            //           height: DEVICE_HEIGHT * 0.017,
                            //         ),
                            //         SizedBox(width: DEVICE_WIDTH * 0.015),
                            //         CustomText(
                            //           text: 'exceptional_appointments'.tr,
                            //           fontSize: 14,
                            //           type: CustomTextType.title,
                            //           color: const Color(
                            //             AppColors.colorLineAndText,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(height: DEVICE_HEIGHT * 0.011),
                            //     SizedBox(
                            //       width: DEVICE_WIDTH * 0.47,
                            //       child: Wrap(
                            //         runSpacing: DEVICE_HEIGHT * 0.01,
                            //         children: (availableTimes).map<Widget>((
                            //           Map<String, dynamic> time,
                            //         ) {
                            //           final List<String> days =
                            //               time['days'] as List<String>;
                            //           final List times = time['times'] as List;
                            //           final String displayDays = days.join(
                            //             ' - ',
                            //           );
                            //           return Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: <Widget>[
                            //               CustomText(
                            //                 text: displayDays,
                            //                 fontSize: 14,
                            //                 type: CustomTextType.title,
                            //                 color: const Color.fromARGB(
                            //                   255,
                            //                   86,
                            //                   93,
                            //                   99,
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                 height: DEVICE_HEIGHT * 0.0027,
                            //               ),
                            //               ...times.map<Widget>((timeItem) {
                            //                 return Padding(
                            //                   padding: EdgeInsets.only(
                            //                     right: DEVICE_WIDTH * 0.015,
                            //                     bottom: DEVICE_HEIGHT * 0.002,
                            //                   ),
                            //                   child: Row(
                            //                     children: <Widget>[
                            //                       Container(
                            //                         width: DEVICE_WIDTH * 0.01,
                            //                         height:
                            //                             DEVICE_HEIGHT * 0.005,
                            //                         color: const Color(
                            //                           AppColors
                            //                               .colorNameSpecialization,
                            //                         ),
                            //                       ),
                            //                       SizedBox(
                            //                         width:
                            //                             DEVICE_WIDTH * 0.0122,
                            //                       ),
                            //                       CustomText(
                            //                         text: timeItem['time']!,
                            //                         fontSize: 12,
                            //                         type: CustomTextType.title,
                            //                         color: const Color(
                            //                           AppColors
                            //                               .colorNameSpecialization,
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 );
                            //               }),
                            //             ],
                            //           );
                            //         }).toList(),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
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
                  width: DEVICE_WIDTH,
                  margin: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: 'qualifications'.tr,
                        fontSize: 14,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorAboutDoctor),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Wrap(
                        spacing: DEVICE_HEIGHT * 0.065,
                        children: (controller.qualifications ?? <dynamic>[])
                            .map<Widget>((qualification) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        qualification['icon'],
                                        width: DEVICE_WIDTH * 0.03,
                                        height: DEVICE_HEIGHT * 0.02,
                                      ),
                                      SizedBox(width: DEVICE_HEIGHT * 0.008),
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        child: CustomText(
                                          text: 'university'.tr,
                                          fontSize: 13,
                                          type: CustomTextType.title,
                                          color: const Color(
                                            AppColors.colorAboutDoctor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.007),
                                  CustomText(
                                    text: qualification['university'],
                                    fontSize: 11,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorNameSpecialization,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.005),
                                  CustomText(
                                    text: qualification['specialization'],
                                    fontSize: 11,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorNameSpecialization,
                                    ),
                                  ),
                                ],
                              );
                            })
                            .toList(),
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
                SizedBox(height: DEVICE_HEIGHT * 0.035),
                SizedBox(
                  width: DEVICE_WIDTH,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: DEVICE_HEIGHT * 0.012),
                          SizedBox(
                            height: DEVICE_HEIGHT * 0.047,
                            width: DEVICE_WIDTH,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(controller.tabs.length, (
                                int index,
                              ) {
                                final bool isActive =
                                    index == controller.isSelected;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: DEVICE_WIDTH * 0.02,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      controller.isSelected = index;
                                      controller.update();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CustomText(
                                          text: controller.tabs[index],
                                          fontSize: 14,
                                          type: CustomTextType.title,
                                          color: isActive
                                              ? const Color(
                                                  AppColors.colorLineAndText,
                                                )
                                              : const Color(
                                                  AppColors
                                                      .colorNameSpecialization,
                                                ),
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                                        AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 150,
                                          ),
                                          curve: Curves.easeInOut,
                                          height: DEVICE_HEIGHT * 0.002,
                                          width: isActive
                                              ? controller.calculateWidth(
                                                  controller.tabs[index],
                                                )
                                              : 0,
                                          decoration: BoxDecoration(
                                            color: isActive
                                                ? const Color(
                                                    AppColors.colorLineAndText,
                                                  )
                                                : const Color(
                                                    AppColors
                                                        .colorNameSpecialization,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 3.5,
                        child: Container(
                          height: DEVICE_HEIGHT * 0.001,
                          width: DEVICE_WIDTH,
                          color: const Color.fromARGB(78, 128, 128, 31),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: DEVICE_HEIGHT * 0.03),
                      CustomText(
                        text:
                            controller.selectedDoctor?['name'] +
                            ' ' +
                            'he_has_experience_in'.tr,
                        fontSize: 16,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorBlack),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.012),
                      Row(
                        children: <Widget>[
                          Container(
                            width: DEVICE_WIDTH * 0.01,
                            height: DEVICE_HEIGHT * 0.005,
                            color: const Color(
                              AppColors.colorNameSpecialization,
                            ),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.0122),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
