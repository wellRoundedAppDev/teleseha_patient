import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Policiesandprocedures extends StatelessWidget {
  const Policiesandprocedures({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Policiesandprocedurescontroller>(
      init: Policiesandprocedurescontroller(),
      builder: (Policiesandprocedurescontroller controller) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_HEIGHT * 0.007,
                ),
                margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: DEVICE_WIDTH,
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: SvgPicture.asset(
                                  iconBack,
                                  width: 24,
                                  height: 26,
                                  // ignore: deprecated_member_use
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: 'policies_and_procedures'.tr,
                                    fontSize: 18,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  SvgPicture.asset(
                                    iconFolders,
                                    width: 24,
                                    height: 26,
                                    // ignore: deprecated_member_use
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: DEVICE_HEIGHT * 0.5,
                                    child: ListView.builder(
                                      itemCount:
                                          controller.listFirstSubject.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final Map<String, dynamic> item =
                                            controller.listFirstSubject[index];
                                        // ignore: always_specify_types
                                        final List innerList =
                                            // ignore: always_specify_types
                                            item['list'] as List;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.02,
                                            ),
                                            CustomText(
                                              text: item['title'],
                                              fontSize: 18,
                                              type: CustomTextType.title,
                                              color: const Color(
                                                AppColors.colorTitleDoppler,
                                              ),
                                            ),
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.01,
                                            ),
                                            if (item['subTitle'] != null &&
                                                item['subTitle']
                                                    .toString()
                                                    .isNotEmpty)
                                              CustomText(
                                                text: item['subTitle'],
                                                fontSize: 12,
                                                type: CustomTextType.title,
                                                color: const Color(
                                                  AppColors.colorSelectDropDown,
                                                ),
                                              ),
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.02,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: innerList.length,
                                              itemBuilder:
                                                  (
                                                    BuildContext context,
                                                    int innerIndex,
                                                  ) {
                                                    // ignore: always_specify_types
                                                    final innerItem =
                                                        innerList[innerIndex];
                                                    // ignore: always_specify_types
                                                    final title =
                                                        innerItem.keys.first;
                                                    // ignore: always_specify_types
                                                    final text =
                                                        innerItem.values.first;

                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text.rich(
                                                          TextSpan(
                                                            children: <InlineSpan>[
                                                              TextSpan(
                                                                text:
                                                                    '${innerIndex + 1}. ',
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                    AppColors
                                                                        .colorSelectDropDown,
                                                                  ),
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: title,
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                    AppColors
                                                                        .colorSelectDropDown,
                                                                  ),
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: text,
                                                                style: const TextStyle(
                                                                  color: Color(
                                                                    AppColors
                                                                        .colorSelectDropDown,
                                                                  ),
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                            ),
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.005,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.05),
                          Column(
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.02),
                              CustomText(
                                text: 'copy_right_tele'.tr,
                                fontSize: 11,
                                type: CustomTextType.title,
                                color: const Color(AppColors.colorTextSkep),
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(routePrivacyPolicy);
                                    },
                                    child: CustomText(
                                      text: 'copy_right_setting'.tr,
                                      fontSize: 11,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.05),
                                  GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(routeTermsAndConditions);
                                    },
                                    child: CustomText(
                                      text: 'terms_and_conditions'.tr,
                                      fontSize: 11,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.05),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(routeTechnicalSupport);
                                    },
                                    child: CustomText(
                                      text: 'technical_support'.tr,
                                      fontSize: 11,
                                      type: CustomTextType.title,
                                      color: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        );
      },
    );
  }
}
