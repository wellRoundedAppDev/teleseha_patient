import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentDoctors extends StatelessWidget {
  const ContentDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();

    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (DoctorsController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text(change.knowNextPage.value),
            if (change.knowNextPage.value ==
                'comping from subSpiecilaties going to profile doctor')
              CustomText(
                text: 'doctors'.tr,
                type: CustomTextType.title,
                fontSize: 16,
                color: const Color(AppColors.colorTitle),
              )
            else
              CustomText(
                text: 'general_specialty_doctors'.tr,
                type: CustomTextType.title,
                fontSize: 16,
                color: const Color(AppColors.colorTitle),
              ),
            SizedBox(height: DEVICE_HEIGHT * 0.033),
            SizedBox(
              // height: DEVICE_HEIGHT * controller.widthSelected,
              height: 240,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0.01,
                    color: const Color(AppColors.colorWhiteSelectedType),
                    margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.02),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                    child: Image.asset(
                                      controller.doctors[index]['image'],
                                      width: DEVICE_WIDTH * 0.2,
                                      height: DEVICE_HEIGHT * 0.12,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 300,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        CustomText(
                                                          text: controller
                                                              .doctors[index]['name']
                                                              .toString()
                                                              .tr,
                                                          type: CustomTextType
                                                              .title,
                                                          fontSize: 13,
                                                          color: const Color(
                                                            AppColors
                                                                .colorTitle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        DEVICE_HEIGHT * 0.004,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      CustomText(
                                                        text: controller
                                                            .doctors[index]['specialization'],
                                                        type: CustomTextType
                                                            .inputTitle,
                                                        fontSize: 13,
                                                        color: const Color(
                                                          AppColors
                                                              .colorNameSpecialization,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            DEVICE_WIDTH *
                                                            0.015,
                                                      ),
                                                      CustomText(
                                                        text: controller
                                                            .doctors[index]['range'],
                                                        type: CustomTextType
                                                            .title,
                                                        fontSize: 13,
                                                        color: const Color(
                                                          AppColors
                                                              .colorSelectDropDown,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            DEVICE_WIDTH *
                                                            0.008,
                                                      ),
                                                      SvgPicture.asset(
                                                        iconStar,
                                                        width:
                                                            DEVICE_WIDTH *
                                                            0.025,
                                                        height:
                                                            DEVICE_HEIGHT *
                                                            0.015,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        DEVICE_HEIGHT * 0.003,
                                                  ),
                                                  CustomText(
                                                    text: controller
                                                        .doctors[index]['reveal'],
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
                                                width: DEVICE_WIDTH * 0.00047,
                                                height: DEVICE_HEIGHT * 0.0001,
                                                size: 12,
                                                textBtn: 'reservation'.tr,
                                                onPressed: () {
                                                  final int doctorId =
                                                      controller
                                                          .doctors[index]['id'];
                                                  controller.passedIndex =
                                                      doctorId;
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
                                        SizedBox(height: DEVICE_HEIGHT * 0.01),
                                        Row(
                                          children: <Widget>[
                                            Wrap(
                                              spacing: 5,
                                              runSpacing: 8.0,
                                              // ignore: always_specify_types
                                              children: List.generate(controller.ratings.length, (
                                                int index,
                                              ) {
                                                // ignore: always_specify_types
                                                final rating =
                                                    controller.ratings[index];
                                                final bool isSelected =
                                                    controller
                                                        .selectedRatingIndex
                                                        .value ==
                                                    index;
                                                return GestureDetector(
                                                  onTap: () {
                                                    controller
                                                            .selectedRatingIndex
                                                            .value =
                                                        index;
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: DEVICE_WIDTH * 0.19,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 7,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color:
                                                              const Color(
                                                                0xFFD8DADC,
                                                              ).withValues(
                                                                alpha: 0.8,
                                                              ),
                                                          blurRadius: 3,
                                                          spreadRadius: 2,
                                                          offset: const Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        ),
                                                      ],
                                                      color: isSelected
                                                          ? const Color(
                                                              AppColors
                                                                  .colorLineAndText,
                                                            )
                                                          : const Color(
                                                              AppColors
                                                                  .colorWhiteSelectedType,
                                                            ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        CustomText(
                                                          text:
                                                              rating['titleRatings'] ??
                                                              'good_listen'.tr,
                                                          fontSize: 8,
                                                          type: CustomTextType
                                                              .title,
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
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          rating['icon'] ??
                                                              iconGoodListen,
                                                          width: 13,
                                                          height: 13,
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
                                          ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(
                                    AppColors.colorLineAndText,
                                  ),
                                ),
                                child: CustomText(
                                  text: controller.doctors[index]['salary'],
                                  type: CustomTextType.title,
                                  fontSize: 14,
                                  color: const Color(
                                    AppColors.colorWhiteSelectedType,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final int doctorId =
                                      controller.doctors[index]['id'];

                                  controller.passedIndex = doctorId;

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
                                    SizedBox(width: DEVICE_WIDTH * 0.02),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
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
        );
      },
    );
  }
}
