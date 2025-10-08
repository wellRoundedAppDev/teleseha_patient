// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/svg.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.03),
            Container(
              margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.055),
              child: CustomText(
                text: controller.doctorsProfile['name'] ?? '',
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
                            text: controller.doctorsProfile['specialty'] ?? '',
                            fontSize: 12,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorLineAndText),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.014),
                          Row(
                            children: <Widget>[
                              CustomText(
                                text:
                                    controller.doctorsProfile['ratingCount']
                                        ?.toString() ??
                                    '0',
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
                                text:
                                    '(${controller.doctorsProfile['ratingValue']?.toString() ?? ''} ${'detection_times'.tr})',
                                fontSize: 11,
                                type: CustomTextType.inputTitle,
                                color: const Color(
                                  AppColors.colorNameSpecialization,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.025),
                          CustomText(
                            text:
                                '${'price_examination'.tr} ${controller.doctorsProfile['price']?.toString() ?? ''} ج',
                            fontSize: 12,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorLineAndText),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.025),
                          CustomText(
                            text:
                                '${'price_consultation'.tr} ${controller.doctorsProfile['followUpCount']?.toString() ?? ''} ج',
                            fontSize: 12,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorLineAndText),
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
                                      text:
                                          controller
                                              .doctorsProfile['doctorProfile']?['description']
                                              ?.toString() ??
                                          '0',
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
                                          controller
                                              .doctorsProfile['doctorProfile']?['address']
                                              ?.toString() ??
                                          '0',
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
                                            (controller.doctorsProfile['schedules']
                                                    as List<dynamic>?)
                                                ?.map<Widget>((scheduleItem) {
                                                  final Map<String, dynamic>
                                                  time =
                                                      scheduleItem
                                                          as Map<
                                                            String,
                                                            dynamic
                                                          >;

                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      CustomText(
                                                        text:
                                                            time['day']
                                                                ?.toString() ??
                                                            '0',
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
                                                      Padding(
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
                                                                  time['startTime']
                                                                      ?.toString() ??
                                                                  '0',
                                                              fontSize: 13,
                                                              type:
                                                                  CustomTextType
                                                                      .title,
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
                                                            const CustomText(
                                                              text: '-',
                                                              fontSize: 13,
                                                              type:
                                                                  CustomTextType
                                                                      .title,
                                                              color: Color(
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
                                                                  time['endTime']
                                                                      ?.toString() ??
                                                                  '0',
                                                              fontSize: 13,
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
                                                      ),
                                                    ],
                                                  );
                                                })
                                                .toList() ??
                                            <Widget>[],
                                      ),
                                    ),
                                  ],
                                ),
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
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        iconUniversity,
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
                                    text:
                                        controller
                                            .doctorsProfile['doctorProfile']?['university']
                                            ?.toString() ??
                                        'university'.tr,
                                    fontSize: 11,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorNameSpecialization,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        iconAcademicDegree,
                                        width: DEVICE_WIDTH * 0.03,
                                        height: DEVICE_HEIGHT * 0.02,
                                      ),
                                      SizedBox(width: DEVICE_HEIGHT * 0.008),
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        child: CustomText(
                                          text: 'academic_degree'.tr,
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
                                    text:
                                        controller
                                            .doctorsProfile['scientificDegree']
                                            ?.toString() ??
                                        'academic_degree'.tr,
                                    fontSize: 11,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorNameSpecialization,
                                    ),
                                  ),
                                ],
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
                            bottom: 1,
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
                                    text:
                                        '${controller.doctorsProfile['name']?.toString() ?? '0'} ${'he_has_experience_in'.tr}',
                                    fontSize: 16,
                                    type: CustomTextType.title,
                                    color: const Color(AppColors.colorBlack),
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.012),
                                  CustomText(
                                    text:
                                        controller
                                            .doctorsProfile['doctorProfile']?['experiences']
                                            ?.toString() ??
                                        '0',
                                    fontSize: 12,
                                    type: CustomTextType.button,
                                    color: const Color(
                                      AppColors.colorNameSpecialization,
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: controller.heHasExperienceIn.map((
                                  //     String e,
                                  //   ) {
                                  //     return Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //         vertical: DEVICE_HEIGHT * 0.005,
                                  //       ),
                                  //       child: Row(
                                  //         children: <Widget>[
                                  //           Container(
                                  //             width: DEVICE_WIDTH * 0.01,
                                  //             height: DEVICE_HEIGHT * 0.005,
                                  //             color: const Color(
                                  //               AppColors
                                  //                   .colorNameSpecialization,
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             width: DEVICE_WIDTH * 0.025,
                                  //           ),
                                  //           Expanded(
                                  //             child: CustomText(
                                  //               text: e,
                                  //               fontSize: 12,
                                  //               type: CustomTextType.button,
                                  //               color: const Color(
                                  //                 AppColors
                                  //                     .colorNameSpecialization,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     );
                                  //   }).toList(),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // start commints
                        if (controller.isSelected == 1)
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: DEVICE_HEIGHT * 0.04,
                              horizontal: DEVICE_WIDTH * 0.055,
                            ),
                            height:
                                controller.doctorsProfile['reviews'].isNotEmpty
                                ? DEVICE_HEIGHT * 0.4
                                : DEVICE_HEIGHT * 0.1,
                            child:
                                controller.doctorsProfile['reviews'] != null &&
                                    controller
                                        .doctorsProfile['reviews']
                                        .isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: controller
                                        .doctorsProfile['reviews']
                                        .length,
                                    itemBuilder: (BuildContext context, int index) {
                                      // ignore: always_specify_types
                                      final review = controller
                                          .doctorsProfile['reviews'][index];
                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: DEVICE_WIDTH * 0.7,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    101,
                                                    196,
                                                    226,
                                                    0.11,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      DEVICE_WIDTH * 0.045,
                                                  vertical:
                                                      DEVICE_HEIGHT * 0.015,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    CustomText(
                                                      text:
                                                          review?['doctor']
                                                              ?.toString() ??
                                                          'تعليق الطبيب',
                                                      fontSize: 12,
                                                      type:
                                                          CustomTextType.title,
                                                      color: const Color(
                                                        AppColors
                                                            .colorLineAndText,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.01,
                                                    ),
                                                    CustomText(
                                                      text:
                                                          review?['review']
                                                              ?.toString() ??
                                                          'تعليق',
                                                      fontSize: 12,
                                                      type:
                                                          CustomTextType.title,
                                                      color: const Color(
                                                        AppColors
                                                            .colorLineAndText,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.01,
                                                    ),
                                                    RatingBar.builder(
                                                      itemSize: 17,
                                                      initialRating:
                                                          (review?['callTimeRating'] ??
                                                                  0)
                                                              .toDouble(),
                                                      minRating: 1,
                                                      ignoreGestures: true,
                                                      allowHalfRating: true,
                                                      itemPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 1.5,
                                                          ),
                                                      unratedColor: const Color(
                                                        AppColors.colorWhite,
                                                      ),
                                                      itemBuilder:
                                                          (
                                                            BuildContext
                                                            context,
                                                            _,
                                                          ) => const Icon(
                                                            Icons.star,
                                                            color: Color(
                                                              AppColors
                                                                  .colorGoldRainsStar,
                                                            ),
                                                          ),
                                                      onRatingUpdate:
                                                          (double rating) =>
                                                              consoleLog(
                                                                rating,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: DEVICE_HEIGHT * 0.02,
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CustomText(
                                      text: 'dont_have_commint',
                                      fontSize: 14,
                                      type: CustomTextType.title,
                                      color: Colors.grey,
                                    ),
                                  ),
                            // child: ListView.builder(
                            //   padding: EdgeInsets.zero,
                            //   itemCount:
                            //       controller.doctorsProfile['reviews'].length,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return Column(
                            //       children: <Widget>[
                            //         Row(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: <Widget>[
                            //             Container(
                            //               width: DEVICE_WIDTH * 0.7,
                            //               decoration: BoxDecoration(
                            //                 color: const Color.fromRGBO(
                            //                   101,
                            //                   196,
                            //                   226,
                            //                   0.11,
                            //                 ),
                            //                 borderRadius: BorderRadius.circular(
                            //                   10,
                            //                 ),
                            //               ),
                            //               padding: EdgeInsets.symmetric(
                            //                 horizontal: DEVICE_WIDTH * 0.045,
                            //                 vertical: DEVICE_HEIGHT * 0.015,
                            //               ),
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: <Widget>[
                            //                   CustomText(
                            //                     text:
                            //                         controller
                            //                             .doctorsProfile['reviews'][index]?['doctor']
                            //                             ?.toString() ??
                            //                         'تعليق الطبيب',
                            //                     fontSize: 12,
                            //                     type: CustomTextType.title,
                            //                     color: const Color(
                            //                       AppColors.colorLineAndText,
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     height: DEVICE_HEIGHT * 0.01,
                            //                   ),
                            //                   CustomText(
                            //                     text:
                            //                         controller
                            //                             .doctorsProfile['reviews'][index]?['review']
                            //                             ?.toString() ??
                            //                         'تعليق',
                            //                     fontSize: 12,
                            //                     type: CustomTextType.title,
                            //                     color: const Color(
                            //                       AppColors.colorLineAndText,
                            //                     ),
                            //                   ),
                            //                   SizedBox(
                            //                     height: DEVICE_HEIGHT * 0.01,
                            //                   ),
                            //                   RatingBar.builder(
                            //                     itemSize: 17,
                            //                     initialRating:
                            //                         (controller.doctorsProfile['reviews'][index]?['callTimeRating'] ??
                            //                                 0)
                            //                             .toDouble(),
                            //                     minRating: 1,
                            //                     ignoreGestures: true,
                            //                     allowHalfRating: true,
                            //                     itemPadding:
                            //                         const EdgeInsets.symmetric(
                            //                           horizontal: 1.5,
                            //                         ),
                            //                     unratedColor: const Color(
                            //                       AppColors.colorWhite,
                            //                     ),
                            //                     itemBuilder:
                            //                         (
                            //                           BuildContext context,
                            //                           _,
                            //                         ) => const Icon(
                            //                           Icons.star,
                            //                           color: Color(
                            //                             AppColors
                            //                                 .colorGoldRainsStar,
                            //                           ),
                            //                         ),
                            //                     onRatingUpdate:
                            //                         (double rating) {
                            //                           consoleLog(rating);
                            //                         },
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         SizedBox(height: DEVICE_HEIGHT * 0.02),
                            //       ],
                            //     );
                            //   },
                            // ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: DEVICE_HEIGHT * 0.015,
                bottom: DEVICE_HEIGHT * 0.025,
              ),
              child: Align(
                child: Btn(
                  onPressed: () async {
                    final int doctorId = controller.doctorsProfile['doctorId'];

                    controller.passedIndex = doctorId;

                    await controller.doctorsProfileRequest();

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
