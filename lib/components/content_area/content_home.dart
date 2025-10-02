import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class ContentHome extends StatelessWidget {
  ContentHome({super.key});
  final BottomNavController bottomController = Get.put(BottomNavController());
  final DoctorsController doctors = Get.put(DoctorsController());
  final ChangeParamContentAndNextPage change = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      builder: (HomePageContentController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (controller.checkComming.isNotEmpty)
              GestureDetector(
                onTap: () {
                  change.goToComponentHeader.value = 'RecentBookings';
                  change.update();
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
                            fontSize: 12,
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
            if (controller.checkComming.isNotEmpty)
              SizedBox(height: DEVICE_HEIGHT * 0.02)
            else
              const SizedBox(),
            Container(
              margin: EdgeInsets.only(
                top: DEVICE_HEIGHT * 0.01,
                left: DEVICE_WIDTH * 0.01,
              ),
              child: CustomText(
                text: 'specialties'.tr,
                fontSize: 16,
                type: CustomTextType.title,
                color: const Color(AppColors.colorSpecialties),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.022),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  child: controller.isLoading
                      ? SizedBox(
                          height: DEVICE_HEIGHT * 0.4,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Wrap(
                          spacing: controller.checkComming.isNotEmpty
                              ? DEVICE_HEIGHT * 0.005
                              : 1,
                          runSpacing: DEVICE_HEIGHT * 0.018,
                          // ignore: always_specify_types
                          children: List.generate(
                            controller.specialties.length,
                            (int index) {
                              // ignore: always_specify_types
                              final e = controller.specialties[index];

                              final String iconPath =
                                  e['icon'] as String? ?? iconGeneralSpecialty;
                              final String specialityName =
                                  e['specialityName'] as String? ?? 'غير معروف';

                              return Card(
                                elevation: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.openContentDoctorsAboutSelected(
                                      index,
                                    );
                                  },
                                  child: Container(
                                    width: DEVICE_WIDTH * 0.252,
                                    height: DEVICE_HEIGHT * 0.147,
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        AppColors.colorWhiteSelectedType,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          iconPath,
                                          width: DEVICE_WIDTH * 0.05,
                                          height: DEVICE_HEIGHT * 0.05,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.013),
                                        CustomText(
                                          textAlign: TextAlign.center,
                                          text: specialityName,
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
                              );
                            },
                          ),
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
