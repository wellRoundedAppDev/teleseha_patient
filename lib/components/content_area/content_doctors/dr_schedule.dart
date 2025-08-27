import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class DrSchedule extends StatelessWidget {
  const DrSchedule({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        controller.selectedDoctorFunction();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.065),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.asset(
                      controller.selectedDoctor?['image'],
                      width: DEVICE_WIDTH * 0.225,
                      height: DEVICE_HEIGHT * 0.1,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomText(
                              text: controller.selectedDoctor?['name'],
                              type: CustomTextType.title,
                              fontSize: 16,
                              color: const Color(AppColors.colorTitle),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.004),
                      Row(
                        children: <Widget>[
                          CustomText(
                            text: controller.selectedDoctor?['specialization'],
                            type: CustomTextType.inputTitle,
                            fontSize: 14,
                            color: const Color(
                              AppColors.colorNameSpecialization,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.015),
                      Row(
                        children: <Widget>[
                          CustomText(
                            text: controller.selectedDoctor?['range'],
                            type: CustomTextType.title,
                            fontSize: 14,
                            color: const Color(AppColors.colorSelectDropDown),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.008),
                          SvgPicture.asset(
                            iconStar,
                            width: DEVICE_WIDTH * 0.025,
                            height: DEVICE_HEIGHT * 0.015,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.028),
            Container(
              height: DEVICE_HEIGHT * 0.001,
              width: DEVICE_WIDTH,
              color: const Color.fromARGB(78, 128, 128, 31),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.025),
            Container(
              padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.065),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: 'timetable'.tr,
                    type: CustomTextType.title,
                    fontSize: 14,
                    color: const Color(AppColors.colorSelectDropDown),
                  ),
                  GestureDetector(
                    onTap: () => controller.pickDate(context),
                    child: Row(
                      children: <Widget>[
                        CustomText(
                          text: controller.selectedMonthName.tr,
                          type: CustomTextType.title,
                          fontSize: 14,
                          color: const Color(AppColors.colorNameSpecialization),
                        ),
                        SizedBox(width: DEVICE_WIDTH * 0.01),
                        SvgPicture.asset(iconDown, width: 20, height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 18),
            SizedBox(height: DEVICE_HEIGHT * 0.022),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        CustomText(
                          text: controller.selectedMonthName.tr,
                          type: CustomTextType.title,
                          fontSize: 14,
                          color: const Color(AppColors.colorNameSpecialization),
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: controller.selectedMonthName.tr,
                          type: CustomTextType.title,
                          fontSize: 14,
                          color: const Color(AppColors.colorNameSpecialization),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
