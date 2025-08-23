import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentDoctors extends StatelessWidget {
  const ContentDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (DoctorsController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: 'general_specialty_doctors'.tr,
              type: CustomTextType.title,
              fontSize: 16,
              color: const Color(AppColors.colorTitle),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.027),
            SizedBox(
              height: DEVICE_HEIGHT * 0.47,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: controller.doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.02),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsetsGeometry.only(
                            top: DEVICE_HEIGHT * 0.016,
                            left: DEVICE_WIDTH * 0.04,
                            right: DEVICE_WIDTH * 0.04,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                    child: Image.asset(
                                      controller.doctors[index]['image'],
                                      width: DEVICE_WIDTH * 0.25,
                                      height: DEVICE_HEIGHT * 0.125,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.017),
                                  SizedBox(
                                    width: DEVICE_WIDTH * 0.55,
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
                                                              .doctors[index]['name'],
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
                                                    fontSize: 13,
                                                    color: const Color(
                                                      AppColors
                                                          .colorNameSpecialization,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              StyleBtnHeader(
                                                width: 0.175,
                                                size: 12,
                                                textBtn: 'reservation'.tr,
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.008),
                                        SizedBox(
                                          width: 220,
                                          child: Expanded(
                                            child: Wrap(
                                              spacing: 8,
                                              runSpacing: 6,
                                              children: List.generate(
                                                controller
                                                    .doctors[index]['skills']
                                                    .length,
                                                (int skillIndex) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              DEVICE_WIDTH *
                                                              0.04,
                                                          vertical:
                                                              DEVICE_HEIGHT *
                                                              0.007,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                            64,
                                                            195,
                                                            218,
                                                            235,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: CustomText(
                                                      text: controller
                                                          .doctors[index]['skills'][skillIndex],
                                                      type:
                                                          CustomTextType.title,
                                                      fontSize: 8,
                                                      color: const Color(
                                                        AppColors
                                                            .colorLineAndText,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.006),
                        const Divider(
                          color: Color(AppColors.colorLineDoctors),
                          thickness: 1,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.01),
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
                                  consoleLog('test');
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
                                        iconArraw,
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
