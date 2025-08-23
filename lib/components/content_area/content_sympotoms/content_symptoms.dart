import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class ContentSymptoms extends StatelessWidget {
  const ContentSymptoms({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentSympotomsController>(
      builder: (ContentSympotomsController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                TextField(
                  controller: controller.filter,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'search_about_sympotoms'.tr,
                    hintStyle: const TextStyle(
                      color: Color(AppColors.colorHintText),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: DEVICE_WIDTH * 0.06,
                      vertical: DEVICE_HEIGHT * 0.022,
                    ),
                    filled: true,
                    fillColor: const Color(AppColors.colorWhiteSelectedType),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                // create post request when add symptoms
                Positioned(
                  left: DEVICE_WIDTH * 0.055,
                  top: DEVICE_HEIGHT * 0.028,
                  child: SvgPicture.asset(
                    iconSearch,
                    width: DEVICE_WIDTH * 0.025,
                    height: DEVICE_HEIGHT * 0.025,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomText(
              text: 'sympotoms'.tr,
              fontSize: 20,
              color: const Color(AppColors.colorSpecialties),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxWidth = constraints.maxWidth;
                final double spacing = controller.spacing;
                return SizedBox(
                  height: DEVICE_HEIGHT * 0.42,
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 16,
                      spacing: spacing,
                      children: List.generate(controller.items.length, (
                        int index,
                      ) {
                        double itemWidth = controller.calculateItemWidth(
                          index,
                          maxWidth,
                        );
                        return Container(
                          width: itemWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.03,
                            vertical: DEVICE_HEIGHT * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                              color: const Color(AppColors.colorSymptomsBorder),
                            ),
                            color: const Color(
                              AppColors.colorWhiteSelectedType,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: const Color(
                                  0xFFD8DADC,
                                ).withValues(alpha: 0.4),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: CustomText(
                                  text: controller.items[index]['title'],
                                  fontSize: 10,
                                  color: const Color(
                                    AppColors.colorSpecialties,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: DEVICE_WIDTH * 0.05,
                                height: DEVICE_HEIGHT * 0.021,
                                child: Checkbox(
                                  value: controller.items[index]['isSelected'],
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      controller.changeValueCheck(index, value);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  activeColor: const Color(
                                    AppColors.colorLineAndText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.015),
            Btn(onPressed: () {}, text: 'diagnosisOfMyCondition'.tr),
          ],
        );
      },
    );
  }
}
