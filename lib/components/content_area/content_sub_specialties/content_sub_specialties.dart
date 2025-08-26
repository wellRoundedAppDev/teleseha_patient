import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentSubSpecialties extends StatelessWidget {
  const ContentSubSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      init: HomePageContentController(),
      builder: (HomePageContentController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(
                text: 'sub_specialist'.tr,
                fontSize: 18,
                type: CustomTextType.title,
                color: const Color(AppColors.colorSpecialties),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.024),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    height: DEVICE_HEIGHT * 0.52,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          if (controller
                                  .specialtiesWithSub[controller
                                      .selectedSpecialtyIndex]['subSpecialties']
                                  .length >=
                              2)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: buildItem(
                                    controller,
                                    controller.specialtiesWithSub[controller
                                        .selectedSpecialtyIndex]['subSpecialties'][0],
                                    0,
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.02),
                                Expanded(
                                  flex: 2,
                                  child: buildItem(
                                    controller,
                                    controller.specialtiesWithSub[controller
                                        .selectedSpecialtyIndex]['subSpecialties'][1],
                                    1,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                          // ignore: always_specify_types
                          ...List.generate(
                            controller
                                    .specialtiesWithSub[controller
                                        .selectedSpecialtyIndex]['subSpecialties']
                                    .length -
                                2,
                            (int i) => Container(
                              margin: EdgeInsets.only(
                                bottom: DEVICE_HEIGHT * 0.02,
                              ),
                              child: buildItem(
                                controller,
                                controller.specialtiesWithSub[controller
                                    .selectedSpecialtyIndex]['subSpecialties'][i +
                                    2],
                                i + 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: always_specify_types
Widget buildItem(controller, Map item, int index) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: DEVICE_WIDTH * 0.035,
      vertical: DEVICE_HEIGHT * 0.022,
    ),
    decoration: BoxDecoration(
      color: const Color(AppColors.colorWhiteSelectedType),
      border: Border.all(color: const Color.fromARGB(50, 102, 102, 44)),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomText(
          text: item['title'],
          fontSize: 11,
          color: const Color(AppColors.colorSelectDropDown),
        ),
        SvgPicture.asset(
          item['icon'],
          width: DEVICE_WIDTH * 0.1,
          height: DEVICE_HEIGHT * 0.027,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
