import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class DrSchedule extends StatelessWidget {
  const DrSchedule({super.key});
  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
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
                              text: controller.selectedDoctor?['name']
                                  .toString()
                                  .tr,
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
            SizedBox(height: DEVICE_HEIGHT * 0.021),
            SizedBox(
              height: DEVICE_HEIGHT * 0.105,
              child: ListView.builder(
                itemCount: controller.weekDays.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final WeekDay day = controller.weekDays[index];
                  final bool isAvailable = day.isAvailable;
                  final bool isSelected = controller.selectedDayIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(left: DEVICE_HEIGHT * 0.022),
                    child: GestureDetector(
                      onTap: () {
                        if (isAvailable) {
                          controller.selectDay(index);
                        }
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected
                              ? const Color(AppColors.colorLineAndText)
                              : (isAvailable
                                    ? const Color(
                                        AppColors.colorWhiteSelectedType,
                                      )
                                    : const Color.fromARGB(24, 144, 144, 147)),
                          boxShadow: <BoxShadow>[
                            if (isSelected || isAvailable)
                              BoxShadow(
                                color: const Color(
                                  0xFFD8DADC,
                                ).withValues(alpha: 0.4),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            else
                              BoxShadow(
                                color: const Color(
                                  0xFFD8DADC,
                                ).withValues(alpha: 0),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            CustomText(
                              text: day.dayName,
                              type: CustomTextType.title,
                              fontSize: 13,
                              color: isSelected
                                  ? const Color(
                                      AppColors.colorWhiteSelectedType,
                                    )
                                  : (isAvailable
                                        ? const Color(
                                            AppColors.colorLineAndText,
                                          )
                                        : const Color.fromARGB(57, 0, 0, 0)),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.007),
                            CustomText(
                              text: '${day.date}',
                              type: CustomTextType.title,
                              fontSize: 24,
                              color: isSelected
                                  ? const Color(
                                      AppColors.colorWhiteSelectedType,
                                    )
                                  : (isAvailable
                                        ? const Color.fromARGB(186, 0, 0, 0)
                                        : const Color.fromARGB(57, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.035),
            Container(
              padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.065),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomText(
                        text: 'time'.tr,
                        type: CustomTextType.title,
                        fontSize: 14,
                        color: const Color(AppColors.colorSelectDropDown),
                      ),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.025),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.182,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: DEVICE_WIDTH * 0.04,
                        runSpacing: DEVICE_HEIGHT * 0.013,
                        children:
                            (controller.availableTimes
                                    as List<Map<String, dynamic>>)
                                .expand<Widget>((Map<String, dynamic> time) {
                                  // ignore: always_specify_types
                                  final List times = time['times'] as List;
                                  // ignore: always_specify_types
                                  return times.map<Widget>((timeItem) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectedTime =
                                            timeItem['time'];
                                        controller.update();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: DEVICE_WIDTH * 0.415,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.selectedTime ==
                                                  timeItem['time']
                                              ? const Color(
                                                  AppColors.colorLineAndText,
                                                )
                                              : const Color.fromRGBO(
                                                  171,
                                                  211,
                                                  233,
                                                  0.50,
                                                ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: DEVICE_WIDTH * 0.033,
                                          vertical: DEVICE_HEIGHT * 0.013,
                                        ),
                                        child: CustomText(
                                          text: timeItem['time'],
                                          type: CustomTextType.title,
                                          fontSize: 12,
                                          color:
                                              controller.selectedTime ==
                                                  timeItem['time']
                                              ? Colors.white
                                              : const Color(
                                                  AppColors.colorLineAndText,
                                                ),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                })
                                .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.07),
            Align(
              child: Btn(
                onPressed: () {
                  controller.saveDateWithDay();
                  change.goToComponentHeader.value = 'enterSymptoms';
                  change.update();
                },
                text: 'reservation'.tr,
              ),
            ),
          ],
        );
      },
    );
  }
}
