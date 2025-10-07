import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class DrSchedule extends StatelessWidget {
  const DrSchedule({super.key});
  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<DoctorsController>(
      initState: (_) {
        final DoctorsController controller = Get.find<DoctorsController>();
        controller.doctorsProfileSessionsRequest();
      },
      builder: (DoctorsController controller) {
        final List<Map<String, dynamic>> filteredSessions = controller
            .doctorsProfileSessions
            .where(
              (Map<String, dynamic> session) =>
                  session['date'] == controller.savedDateWithDay,
            )
            .toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_WIDTH * 0.065,
                  vertical: DEVICE_HEIGHT * 0.01,
                ),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.network(
                        controller.doctorsProfile['imageUrl'] ?? '',
                        width: DEVICE_WIDTH * 0.23,
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
                                width: DEVICE_WIDTH * 0.23,
                                height: DEVICE_HEIGHT * 0.12,
                                fit: BoxFit.cover,
                              );
                            },
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
                                text: controller.doctorsProfile['name'] ?? '',
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
                              text:
                                  controller.doctorsProfile['specialty'] ?? '',
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
                              text:
                                  controller.doctorsProfile['ratingCount']
                                      ?.toString() ??
                                  '0',
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
                        SizedBox(width: DEVICE_WIDTH * 0.015),
                        Row(
                          children: <Widget>[
                            CustomText(
                              text:
                                  '${'price_examination'.tr} ${controller.doctorsProfile['price']?.toString() ?? ''} ج',
                              fontSize: 10,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorLineAndText),
                            ),
                            const SizedBox(width: 17),
                            CustomText(
                              text:
                                  '${'price_consultation'.tr} ${controller.doctorsProfile['followUpCount']?.toString() ?? ''} ج',
                              fontSize: 10,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorLineAndText),
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
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_WIDTH * 0.065,
                  vertical: DEVICE_HEIGHT * 0.01,
                ),
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
                            color: const Color(
                              AppColors.colorNameSpecialization,
                            ),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.01),
                          SvgPicture.asset(iconDown, width: 20, height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: DEVICE_HEIGHT * 0.135,
                child: ListView.builder(
                  itemCount: controller.weekDays.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final WeekDay day = controller.weekDays[index];
                    final bool isAvailable = day.isAvailable;
                    final bool isSelected =
                        controller.selectedDayIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(left: DEVICE_HEIGHT * 0.022),
                      child: GestureDetector(
                        onTap: () {
                          if (isAvailable) {
                            controller.selectDay(index);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isSelected
                                  ? const Color(AppColors.colorLineAndText)
                                  : (isAvailable
                                        ? const Color(
                                            AppColors.colorWhiteSelectedType,
                                          )
                                        : const Color.fromARGB(
                                            24,
                                            144,
                                            144,
                                            147,
                                          )),
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                            : const Color.fromARGB(
                                                57,
                                                0,
                                                0,
                                                0,
                                              )),
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
                                            : const Color.fromARGB(
                                                57,
                                                0,
                                                0,
                                                0,
                                              )),
                                ),
                              ],
                            ),
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
                      height: filteredSessions.isEmpty
                          ? DEVICE_HEIGHT * 0.05
                          : DEVICE_HEIGHT * 0.25,
                      child: SingleChildScrollView(
                        child: filteredSessions.isEmpty
                            ? Center(
                                child: CustomText(
                                  text: 'dont_have_times'.tr,
                                  fontSize: 16,
                                  color: const Color(
                                    AppColors.colorLineAndText,
                                  ),
                                  type: CustomTextType.title,
                                ),
                              )
                            : Wrap(
                                spacing: DEVICE_WIDTH * 0.04,
                                runSpacing: DEVICE_HEIGHT * 0.013,
                                children: filteredSessions.map((
                                  Map<String, dynamic> session,
                                ) {
                                  final String startTime = session['start'];
                                  final String endTime = session['end'];
                                  final bool isSelected =
                                      controller.selectedTime == startTime;

                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedTime = startTime;
                                      controller.update();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: DEVICE_WIDTH * 0.415,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(
                                                AppColors.colorLineAndText,
                                              )
                                            : const Color.fromRGBO(
                                                171,
                                                211,
                                                233,
                                                0.50,
                                              ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: DEVICE_WIDTH * 0.033,
                                        vertical: DEVICE_HEIGHT * 0.013,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CustomText(
                                            text: startTime,
                                            type: CustomTextType.title,
                                            fontSize: 12,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                          ),
                                          CustomText(
                                            text: ' - ',
                                            type: CustomTextType.title,
                                            fontSize: 12,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                          ),
                                          CustomText(
                                            text: endTime,
                                            type: CustomTextType.title,
                                            fontSize: 12,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                        // child: Wrap(
                        //   spacing: DEVICE_WIDTH * 0.04,
                        //   runSpacing: DEVICE_HEIGHT * 0.013,
                        //   children: controller.doctorsProfileSessions
                        //       .where(
                        //         (Map<String, dynamic> session) =>
                        //             session['date'] ==
                        //             controller.savedDateWithDay,
                        //       )
                        //       .map<Widget>((Map<String, dynamic> session) {
                        //         final String startTime = session['start'];
                        //         final String endTime = session['end'];

                        //         final bool isSelected =
                        //             controller.selectedTime == startTime;

                        //         return GestureDetector(
                        //           onTap: () {
                        //             controller.selectedTime = startTime;
                        //             controller.update();
                        //           },
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             width: DEVICE_WIDTH * 0.415,
                        //             decoration: BoxDecoration(
                        //               color: isSelected
                        //                   ? const Color(
                        //                       AppColors.colorLineAndText,
                        //                     )
                        //                   : const Color.fromRGBO(
                        //                       171,
                        //                       211,
                        //                       233,
                        //                       0.50,
                        //                     ),
                        //               borderRadius: BorderRadius.circular(20),
                        //             ),
                        //             padding: EdgeInsets.symmetric(
                        //               horizontal: DEVICE_WIDTH * 0.033,
                        //               vertical: DEVICE_HEIGHT * 0.013,
                        //             ),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: <Widget>[
                        //                 CustomText(
                        //                   text: startTime,
                        //                   type: CustomTextType.title,
                        //                   fontSize: 12,
                        //                   color: isSelected
                        //                       ? Colors.white
                        //                       : const Color(
                        //                           AppColors.colorLineAndText,
                        //                         ),
                        //                 ),
                        //                 CustomText(
                        //                   text: ' - ',
                        //                   type: CustomTextType.title,
                        //                   fontSize: 12,
                        //                   color: isSelected
                        //                       ? Colors.white
                        //                       : const Color(
                        //                           AppColors.colorLineAndText,
                        //                         ),
                        //                 ),
                        //                 CustomText(
                        //                   text: endTime,
                        //                   type: CustomTextType.title,
                        //                   fontSize: 12,
                        //                   color: isSelected
                        //                       ? Colors.white
                        //                       : const Color(
                        //                           AppColors.colorLineAndText,
                        //                         ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       })
                        //       .toList(),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                child: Btn(
                  onPressed: () {
                    controller.saveDateWithDay();
                    // change.goToComponentHeader.value = 'enterSymptoms';
                    // change.update();
                  },
                  text: 'reservation'.tr,
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.1),
            ],
          ),
        );
      },
    );
  }
}
