import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentSubSpecialties extends StatelessWidget {
  ContentSubSpecialties({super.key});
  final ChangeParamContentAndNextPage change = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      init: HomePageContentController(),
      builder: (HomePageContentController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(
                text: 'sub_specialist'.tr,
                fontSize: 16,
                type: CustomTextType.title,
                color: const Color(AppColors.colorSpecialties),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.024),
              SizedBox(
                height: DEVICE_HEIGHT * 0.52,
                child: ListView.builder(
                  itemCount: controller
                      .specialtiesWithSub[controller
                          .selectedSpecialtyIndex]['subSpecialties']
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    // ignore: always_specify_types
                    final subSpecialty =
                        controller.specialtiesWithSub[controller
                            .selectedSpecialtyIndex]['subSpecialties'][index];
                    return GestureDetector(
                      onTap: () {
                        change.goToComponentHeader.value = 'Doctors';
                        change.knowNextPage.value =
                            'comping from subSpiecilaties going to profile doctor';
                        change.update();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.034),
                        padding: EdgeInsets.symmetric(
                          vertical: DEVICE_WIDTH * 0.06,
                          horizontal: DEVICE_HEIGHT * 0.035,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(AppColors.colorWhiteSelectedType),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0xFFD8DADC).withAlpha(102),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomText(
                              text: subSpecialty['title'] ?? '',
                              fontSize: 14,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorSelectDropDown),
                            ),
                            SvgPicture.asset(
                              subSpecialty['icon'] ?? '',
                              width: DEVICE_WIDTH * 0.06,
                              height: DEVICE_WIDTH * 0.06,
                            ),
                          ],
                        ),
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
