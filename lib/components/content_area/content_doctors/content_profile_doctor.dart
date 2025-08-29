import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentProfileDoctor extends StatelessWidget {
  const ContentProfileDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();

    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        controller.selectedDoctorFunction();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            Container(
              margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.055),
              child: CustomText(
                text: controller.selectedDoctor?['name'],
                fontSize: 24,
                type: CustomTextType.title,
                color: const Color(AppColors.colorBlack),
              ),
            ),
            Expanded(
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
                                    color: Color(
                                      AppColors.colorNameSpecialization,
                                    ),
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
                              color: const Color(
                                AppColors.colorWhiteSelectedType,
                              ),
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
                                      text:
                                          controller.selectedDoctor?['address'],
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
                                                    as List<
                                                      Map<String, dynamic>
                                                    >)
                                                .map<Widget>((
                                                  Map<String, dynamic> time,
                                                ) {
                                                  final List<String> days =
                                                      time['days']
                                                          as List<String>;
                                                  // ignore: always_specify_types
                                                  final List times =
                                                      // ignore: always_specify_types
                                                      time['times'] as List;
                                                  final String displayDays =
                                                      days.join(' - ');
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      CustomText(
                                                        text: displayDays,
                                                        fontSize: 14,
                                                        type: CustomTextType
                                                            .title,
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              86,
                                                              93,
                                                              99,
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            DEVICE_HEIGHT *
                                                            0.0027,
                                                      ),
                                                      ...times.map<Widget>((
                                                        // ignore: always_specify_types
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
                                                                type:
                                                                    CustomTextType
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
                            children: (controller.qualifications).map<Widget>((
                              Map<String, dynamic> qualification,
                            ) {
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
                            }).toList(),
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
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: DEVICE_WIDTH * 0.055,
                            ),
                            width: DEVICE_WIDTH * 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: DEVICE_HEIGHT * 0.012),
                                SizedBox(
                                  height: DEVICE_HEIGHT * 0.047,
                                  width: DEVICE_WIDTH,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: always_specify_types
                                    children: List.generate(
                                      controller.tabs.length,
                                      (int index) {
                                        final bool isActive =
                                            index == controller.isSelected;
                                        return InkWell(
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
                                                        AppColors
                                                            .colorLineAndText,
                                                      )
                                                    : const Color(
                                                        AppColors
                                                            .colorNameSpecialization,
                                                      ),
                                              ),
                                              SizedBox(
                                                height: DEVICE_HEIGHT * 0.012,
                                              ),
                                              AnimatedContainer(
                                                duration: const Duration(
                                                  milliseconds: 150,
                                                ),
                                                curve: Curves.easeInOut,
                                                height: DEVICE_HEIGHT * 0.0025,
                                                width: isActive
                                                    ? controller.calculateWidth(
                                                        controller.tabs[index],
                                                      )
                                                    : 0,
                                                decoration: BoxDecoration(
                                                  color: isActive
                                                      ? const Color(
                                                          AppColors
                                                              .colorLineAndText,
                                                        )
                                                      : const Color(
                                                          AppColors
                                                              .colorNameSpecialization,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                    IndexedStack(
                      index: controller.isSelected,
                      children: <Widget>[
                        Column(
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
                                    text:
                                        controller.selectedDoctor?['name'] +
                                        // ignore: prefer_interpolation_to_compose_strings
                                        ' ' +
                                        'he_has_experience_in'.tr,
                                    fontSize: 16,
                                    type: CustomTextType.title,
                                    color: const Color(AppColors.colorBlack),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.012),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: controller.heHasExperienceIn.map((
                                      String e,
                                    ) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: DEVICE_HEIGHT * 0.005,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: DEVICE_WIDTH * 0.01,
                                              height: DEVICE_HEIGHT * 0.005,
                                              color: const Color(
                                                AppColors
                                                    .colorNameSpecialization,
                                              ),
                                            ),
                                            SizedBox(
                                              width: DEVICE_WIDTH * 0.025,
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                text: e,
                                                fontSize: 12,
                                                type: CustomTextType.button,
                                                color: const Color(
                                                  AppColors
                                                      .colorNameSpecialization,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
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
                            SizedBox(height: DEVICE_HEIGHT * 0.012),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: DEVICE_WIDTH * 0.055,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: 'clinical_experience'.tr,
                                    fontSize: 16,
                                    type: CustomTextType.title,
                                    color: const Color(AppColors.colorBlack),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.012),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: controller.clinicalExperience.map((
                                      String e,
                                    ) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: DEVICE_HEIGHT * 0.005,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: DEVICE_WIDTH * 0.01,
                                              height: DEVICE_HEIGHT * 0.005,
                                              color: const Color(
                                                AppColors
                                                    .colorNameSpecialization,
                                              ),
                                            ),
                                            SizedBox(
                                              width: DEVICE_WIDTH * 0.025,
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                text: e,
                                                fontSize: 12,
                                                type: CustomTextType.button,
                                                color: const Color(
                                                  AppColors
                                                      .colorNameSpecialization,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.055),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // start ratings
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: DEVICE_WIDTH * 0.055,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: DEVICE_HEIGHT * 0.075),
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.8,
                                    child: CustomText(
                                      text:
                                          // ignore: prefer_interpolation_to_compose_strings
                                          ' ${'evaluate_your_session'.tr}'
                                              ' ' +
                                          controller.selectedDoctor?['name'] +
                                          // ignore: prefer_interpolation_to_compose_strings
                                          ' ' +
                                          'to_help'.tr,
                                      fontSize: 15,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.015),
                                  Center(
                                    child: RatingBar.builder(
                                      minRating: 1,
                                      allowHalfRating: true,
                                      itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1.5,
                                      ),
                                      unratedColor: const Color(
                                        AppColors.colorWhite,
                                      ),
                                      itemBuilder: (BuildContext context, _) =>
                                          const Icon(
                                            Icons.star,
                                            color: Color(
                                              AppColors.colorGoldRainsStar,
                                            ),
                                          ),
                                      onRatingUpdate: (double rating) {
                                        consoleLog(rating);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 8.0,
                                    // ignore: always_specify_types
                                    children: List.generate(controller.ratings.length, (
                                      int index,
                                    ) {
                                      // ignore: always_specify_types
                                      final rating = controller.ratings[index];
                                      final bool isSelected =
                                          controller
                                              .selectedRatingIndex
                                              .value ==
                                          index;
                                      return GestureDetector(
                                        onTap: () {
                                          controller.selectedRatingIndex.value =
                                              index;
                                          controller.update();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: DEVICE_WIDTH * 0.278,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 9,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: const Color(
                                                  0xFFD8DADC,
                                                ).withValues(alpha: 0.8),
                                                blurRadius: 3,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                            color: isSelected
                                                ? const Color(
                                                    AppColors.colorLineAndText,
                                                  )
                                                : const Color(
                                                    AppColors
                                                        .colorWhiteSelectedType,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              CustomText(
                                                text:
                                                    rating['titleRatings'] ??
                                                    'good_listen'.tr,
                                                fontSize: 10,
                                                type: CustomTextType.title,
                                                color: isSelected
                                                    ? const Color(
                                                        AppColors
                                                            .colorWhiteSelectedType,
                                                      )
                                                    : const Color(
                                                        AppColors
                                                            .colorLineAndText,
                                                      ),
                                              ),
                                              const SizedBox(width: 8),
                                              SvgPicture.asset(
                                                rating['icon'] ??
                                                    iconGoodListen,
                                                width: 30,
                                                height: 30,
                                                // ignore: deprecated_member_use
                                                color: isSelected
                                                    ? const Color(
                                                        AppColors
                                                            .colorWhiteSelectedType,
                                                      )
                                                    : const Color(
                                                        AppColors
                                                            .colorGoldRains,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.043),
                                  CustomText(
                                    text: 'what_is_your_comment_on_the_session'
                                        .tr,
                                    fontSize: 15,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.012),
                                  Container(
                                    width: DEVICE_WIDTH,
                                    height: DEVICE_HEIGHT * 0.048,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(
                                          AppColors.colorWhite,
                                        ),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      controller:
                                          controller.yourCommentOnTheSession,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: DEVICE_WIDTH * 0.05,
                                          vertical: DEVICE_HEIGHT * 0.0145,
                                        ),
                                        hintText:
                                            'write_your_comment_about_the_session'
                                                .tr,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(
                                            AppColors.colorHintText,
                                          ).withValues(alpha: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.isSelected == 1)
                              SizedBox(height: DEVICE_HEIGHT * 0.12)
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.025),
              child: Align(
                child: Btn(
                  onPressed: () {
                    change.goToComponentHeader.value = 'drSchedule';
                    change.update();
                  },
                  text: 'reservation'.tr,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
