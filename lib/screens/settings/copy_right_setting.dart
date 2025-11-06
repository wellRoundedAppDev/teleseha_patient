import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CopyRightSettingsConroller>(
      init: CopyRightSettingsConroller(),
      builder: (CopyRightSettingsConroller controller) {
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
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: SvgPicture.asset(
                                  iconBack,
                                  width: 24,
                                  height: 26,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: 'copy_right_setting'.tr,
                                    fontSize: 18,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.02),
                                  SvgPicture.asset(
                                    copyRightSetting,
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
                                children: <Widget>[
                                  Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '${'enter_plat_form'.tr} ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(
                                              AppColors.colorSelectDropDown,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: SvgPicture.asset(
                                            iconLogoLogin,
                                            width: 22,
                                            height: 24,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ${'text_copy_right'.tr}',
                                          style: const TextStyle(
                                            color: Color(
                                              AppColors.colorSelectDropDown,
                                            ),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: DEVICE_HEIGHT * 0.3,
                                    child: ListView.builder(
                                      itemCount:
                                          controller.listFirstSubject.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final item =
                                            controller.listFirstSubject[index];
                                        final innerList = item['list'] as List;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CustomText(
                                              text: item['title'],
                                              fontSize: 18,
                                              type: CustomTextType.title,
                                              color: const Color(
                                                AppColors.colorLineAndText,
                                              ),
                                            ),
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.01,
                                            ),
                                            CustomText(
                                              text: item['subTitle'],
                                              fontSize: 12,
                                              type: CustomTextType.title,
                                              color: const Color(
                                                AppColors.colorSelectDropDown,
                                              ),
                                            ),
                                            SizedBox(
                                              height: DEVICE_HEIGHT * 0.01,
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
                                                    final innerItem =
                                                        innerList[innerIndex];
                                                    final title =
                                                        innerItem.keys.first;
                                                    final text =
                                                        innerItem.values.first;

                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
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
