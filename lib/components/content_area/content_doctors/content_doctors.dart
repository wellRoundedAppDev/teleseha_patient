import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentDoctors extends StatelessWidget {
  ContentDoctors({super.key});

  HomePageContentController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (DoctorsController controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // if (change.knowNextPage.value ==
              //     'comping from subSpiecilaties going to profile doctor')
              CustomText(
                text: controller.showText,
                type: CustomTextType.title,
                fontSize: 16,
                color: const Color(AppColors.colorTitle),
              ),
              // else
              //   CustomText(
              //     text: 'general_specialty_doctors'.tr,
              //     type: CustomTextType.title,
              //     fontSize: 16,
              //     color: const Color(AppColors.colorTitle),
              //   ),
              SizedBox(height: DEVICE_HEIGHT * 0.033),
              SizedBox(
                height: DEVICE_HEIGHT * controller.widthSelected,
                child: controller.isLoadingDoctor
                    ? const Center(child: CircularProgressIndicator())
                    : controller.doctors.isEmpty
                    ? Center(
                        child: CustomText(
                          text: 'not_found_doctors'.tr,
                          type: CustomTextType.title,
                          fontSize: 13,
                          color: const Color(AppColors.colorTitle),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: controller.doctors.length,
                        itemBuilder: (BuildContext context, int index) {
                          // ignore: always_specify_types
                          final doctor = controller.doctors[index];
                          // ignore: always_specify_types
                          final advantages =
                              doctor['availableAdvantages'] ?? <dynamic>[];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0.01,
                            color: const Color(
                              AppColors.colorWhiteSelectedType,
                            ),
                            margin: EdgeInsets.only(
                              bottom: DEVICE_HEIGHT * 0.02,
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    top: DEVICE_HEIGHT * 0.03,
                                    right: DEVICE_WIDTH * 0.05,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  10,
                                                ),
                                            child: Image.network(
                                              controller
                                                      .doctors[index]['imageUrl'] ??
                                                  '',
                                              width: DEVICE_WIDTH * 0.2,
                                              height: DEVICE_HEIGHT * 0.12,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    BuildContext context,
                                                    Object error,
                                                    StackTrace? stackTrace,
                                                  ) {
                                                    return Image.asset(
                                                      imageDoctor,
                                                      width: DEVICE_WIDTH * 0.2,
                                                      height:
                                                          DEVICE_HEIGHT * 0.12,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                            ),
                                          ),
                                          SizedBox(width: DEVICE_WIDTH * 0.02),
                                          SizedBox(
                                            width: DEVICE_WIDTH * 0.6,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 300,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height:
                                                                DEVICE_HEIGHT *
                                                                0.004,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                controller
                                                                    .doctors[index]['name'] ??
                                                                '',
                                                            fontSize: 13,
                                                            color: const Color(
                                                              AppColors
                                                                  .colorNumber,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                DEVICE_HEIGHT *
                                                                0.010,
                                                          ),
                                                          Container(
                                                            width:
                                                                DEVICE_WIDTH *
                                                                0.3,
                                                            child: Text.rich(
                                                              TextSpan(
                                                                children: <InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        controller
                                                                            .doctors[index]['specialty'] ??
                                                                        '',
                                                                    style: const TextStyle(
                                                                      color: Color(
                                                                        AppColors
                                                                            .colorNameSpecialization,
                                                                      ),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text: '  ',
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        controller
                                                                            .doctors[index]['ratingCount']
                                                                            ?.toString() ??
                                                                        '0',
                                                                    style: const TextStyle(
                                                                      color: Color(
                                                                        AppColors
                                                                            .colorSelectDropDown,
                                                                      ),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text: '  ⭐',
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .amber,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                DEVICE_HEIGHT *
                                                                0.003,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '(${controller.doctors[index]['ratingValue']?.toString() ?? ''} ${'detection_times'.tr})',
                                                            type: CustomTextType
                                                                .inputTitle,
                                                            fontSize: 11,
                                                            color: const Color(
                                                              AppColors
                                                                  .colorNameSpecialization,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      StyleBtnHeader(
                                                        width: 0.15,
                                                        height: 0.033,
                                                        size: 12,
                                                        textBtn:
                                                            'reservation'.tr,
                                                        onPressed: () async {
                                                          final int
                                                          doctorId = controller
                                                              .doctors[index]['doctorId'];

                                                          controller
                                                                  .passedIndex =
                                                              doctorId;

                                                          await controller
                                                              .doctorsProfileRequest();

                                                          change
                                                                  .goToComponentHeader
                                                                  .value =
                                                              'drSchedule';
                                                          change.update();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.01,
                                                ),
                                                Wrap(
                                                  spacing: 5,
                                                  runSpacing: 8,
                                                  children: advantages.map<Widget>((
                                                    // ignore: always_specify_types
                                                    adv,
                                                  ) {
                                                    return Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 7,
                                                            horizontal: 10,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                        color: Colors.grey[200],
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            adv['title'] ?? '',
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          SvgPicture.asset(
                                                            adv['icon'] ?? '',
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.007),
                                const Divider(
                                  color: Color.fromARGB(68, 128, 128, 64),
                                  thickness: 1,
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.006),
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: DEVICE_WIDTH * 0.06,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: const Color(
                                            AppColors.colorLineAndText,
                                          ),
                                        ),
                                        child: CustomText(
                                          text:
                                              '${controller.doctors[index]['price']} ج',
                                          type: CustomTextType.title,
                                          fontSize: 14,
                                          color: const Color(
                                            AppColors.colorWhiteSelectedType,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final int doctorId = controller
                                              .doctors[index]['doctorId'];

                                          controller.passedIndex = doctorId;

                                          await controller
                                              .doctorsProfileRequest();

                                          change.goToComponentHeader.value =
                                              'ProfileDoctor';
                                          change.update();
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            CustomText(
                                              text: 'viewProfilesDoctor'.tr,
                                              type: CustomTextType.title,
                                              fontSize: 11,
                                              color: const Color(
                                                AppColors.colorLineAndText,
                                              ),
                                            ),
                                            SizedBox(
                                              width: DEVICE_WIDTH * 0.02,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 3,
                                              ),
                                              child: SvgPicture.asset(
                                                iconArrowGreen,
                                                width: DEVICE_WIDTH * 0.025,
                                                height: DEVICE_HEIGHT * 0.015,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.01),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
