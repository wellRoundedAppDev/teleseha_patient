import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class ContentHome extends StatelessWidget {
  ContentHome({super.key});
  final BottomNavController bottomController = Get.put(BottomNavController());
  final DoctorsController doctors = Get.put(DoctorsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      builder: (HomePageContentController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (controller.checkReservations)
              GestureDetector(
                onTap: () {
                  consoleLog('test');
                },
                child: Container(
                  padding: EdgeInsets.all(DEVICE_WIDTH * 0.047),
                  decoration: BoxDecoration(
                    color: const Color(AppColors.colorLastReception),
                    borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.024),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFD8DADC).withValues(alpha: 0.4),
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CustomText(
                                text: 'Recent_bookings'.tr,
                                fontSize: 16,
                                type: CustomTextType.title,
                                color: const Color(AppColors.colorLineAndText),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.01),
                              SvgPicture.asset(
                                iconRecentBookings,
                                width: DEVICE_WIDTH * 0.1,
                                height: DEVICE_HEIGHT * 0.02,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.01),
                          Row(
                            children: <Widget>[
                              CustomText(
                                text: 'nearest_reservation'.tr,
                                fontSize: 12,
                                type: CustomTextType.title,
                                color: const Color(AppColors.colorSuccessLine),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.02),
                              SvgPicture.asset(
                                iconTime,
                                width: DEVICE_WIDTH * 0.018,
                                height: DEVICE_HEIGHT * 0.018,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.01),
                          Row(
                            children: <Widget>[
                              CustomText(
                                text:
                                    '${'next_reservation'.tr} ${controller.nextReservation}',
                                fontSize: 12,
                                type: CustomTextType.title,
                                color: const Color(AppColors.colorLineAndText),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.01),
                              SvgPicture.asset(
                                iconDateNextReservation,
                                width: DEVICE_WIDTH * 0.018,
                                height: DEVICE_HEIGHT * 0.018,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.011),
                          CustomText(
                            text: 'click_view_details'.tr,
                            fontSize: 10,
                            type: CustomTextType.button,
                            color: const Color(AppColors.colorTextSkep),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        iconArrowRecentBookings,
                        width: 40,
                        height: 38,
                      ),
                    ],
                  ),
                ),
              )
            else
              const SizedBox(),
            if (controller.checkReservations)
              SizedBox(height: DEVICE_HEIGHT * 0.02)
            else
              const SizedBox(),
            CustomText(
              text: 'specialties'.tr,
              fontSize: 18,
              type: CustomTextType.title,
              color: const Color(AppColors.colorSpecialties),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.022),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  child: Wrap(
                    spacing: controller.checkReservations
                        ? DEVICE_HEIGHT * 0.005
                        : 6,
                    runSpacing: DEVICE_HEIGHT * 0.018,
                    children: <Widget>[
                      ...controller.specialtiesWithSub.asMap().map((
                        int index,
                        Map<String, dynamic> e,
                      ) {
                        // ignore: always_specify_types
                        return MapEntry(
                          index,
                          Card(
                            elevation: 1,
                            child: GestureDetector(
                              onTap: () {
                                controller.openContentDoctorsAboutSelected(
                                  index,
                                );
                              },
                              child: Container(
                                width: DEVICE_WIDTH * 0.25,
                                height: DEVICE_HEIGHT * 0.108,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    AppColors.colorWhiteSelectedType,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      e['icon'],
                                      width: DEVICE_WIDTH * 0.05,
                                      height: DEVICE_HEIGHT * 0.05,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: DEVICE_HEIGHT * 0.013),
                                    CustomText(
                                      text: e['title'],
                                      fontSize: 12,
                                      type: CustomTextType.button,
                                      color: const Color(
                                        AppColors.colorSpecialtiesTitle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).values,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
