import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Reports extends StatelessWidget {
   Reports({super.key});
  final ChangeParamContentAndNextPage change = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsController>(
      init: ReportsController(),
      builder: (ReportsController controller) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: 'reports'.tr,
                      fontSize: 18,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorLineAndText),
                    ),
                    SizedBox(width: DEVICE_WIDTH * 0.02),
                    SvgPicture.asset(
                      iconReports,
                      width: 24,
                      height: 26,
                      // ignore: deprecated_member_use
                      color: const Color(AppColors.colorLineAndText),
                    ),
                  ],
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
                SizedBox(
                  width: DEVICE_WIDTH,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: DEVICE_HEIGHT * 0.012),
                            SizedBox(
                              height: DEVICE_HEIGHT * 0.047,
                              width: DEVICE_WIDTH,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: always_specify_types
                                children: List.generate(controller.tabs.length, (
                                  int index,
                                ) {
                                  final bool isActive =
                                      index == controller.isSelected;
                                  return InkWell(
                                    onTap: () {
                                      controller.isSelected = index;
                                      controller.update();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CustomText(
                                          text: controller.tabs[index],
                                          fontSize: 14,
                                          type: CustomTextType.title,
                                          color: isActive
                                              ? const Color(
                                                  AppColors.colorLineAndText,
                                                )
                                              : const Color(
                                                  AppColors
                                                      .colorNameSpecialization,
                                                ),
                                        ),
                                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                                        AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 150,
                                          ),
                                          curve: Curves.easeInOut,
                                          height: DEVICE_HEIGHT * 0.0025,
                                          width: isActive
                                              ? controller.calculateWidth(
                                                  controller.tabs[index],
                                                )
                                              : 0,
                                          decoration: BoxDecoration(
                                            color: isActive
                                                ? const Color(
                                                    AppColors.colorLineAndText,
                                                  )
                                                : const Color(
                                                    AppColors
                                                        .colorNameSpecialization,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: DEVICE_HEIGHT * 0.001,
                          width: DEVICE_WIDTH,
                          color: const Color.fromARGB(78, 128, 128, 31),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.045),
                IndexedStack(
                  index: controller.isSelected,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.heHasExperienceIn.map((
                                  String e,
                                ) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DEVICE_HEIGHT * 0.005,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: DEVICE_WIDTH * 0.01,
                                          height: DEVICE_HEIGHT * 0.005,
                                          color: const Color(
                                            AppColors.colorNameSpecialization,
                                          ),
                                        ),
                                        SizedBox(width: DEVICE_WIDTH * 0.025),
                                        Expanded(
                                          child: CustomText(
                                            text: e,
                                            fontSize: 12,
                                            type: CustomTextType.button,
                                            color: const Color(
                                              AppColors.colorNameSpecialization,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              SizedBox(
                                height: DEVICE_HEIGHT * 0.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.doctors.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 0.5,
                                          color: const Color(
                                            AppColors.colorWhiteSelectedType,
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom: DEVICE_HEIGHT * 0.02,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsGeometry.symmetric(
                                                  horizontal: 15,
                                                  vertical: 25,
                                                ),
                                            child: Row(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        10,
                                                      ),
                                                  child: Image.asset(
                                                    controller
                                                        .doctors[index]['image'],
                                                    width: DEVICE_WIDTH * 0.16,
                                                    height:
                                                        DEVICE_HEIGHT * 0.09,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: DEVICE_WIDTH * 0.06,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    CustomText(
                                                      text: controller
                                                          .doctors[index]['name']
                                                          .toString()
                                                          .tr,
                                                      type:
                                                          CustomTextType.title,
                                                      fontSize: 13,
                                                      color: const Color(
                                                        AppColors.colorTitle,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.01,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        CustomText(
                                                          text: controller
                                                              .doctors[index]['specialization'],
                                                          type: CustomTextType
                                                              .inputTitle,
                                                          fontSize: 10,
                                                          color: const Color(
                                                            AppColors
                                                                .colorNameSpecialization,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              DEVICE_WIDTH *
                                                              0.015,
                                                        ),
                                                        CustomText(
                                                          text: controller
                                                              .doctors[index]['range'],
                                                          type: CustomTextType
                                                              .inputTitle,
                                                          fontSize: 10,
                                                          color: const Color(
                                                            AppColors
                                                                .colorSelectDropDown,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              DEVICE_WIDTH *
                                                              0.008,
                                                        ),
                                                        SvgPicture.asset(
                                                          iconStar,
                                                          width:
                                                              DEVICE_WIDTH *
                                                              0.025,
                                                          height:
                                                              DEVICE_HEIGHT *
                                                              0.015,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.01,
                                                    ),
                                                    CustomText(
                                                      text: controller
                                                          .doctors[index]['date_revelation'],
                                                      type:
                                                          CustomTextType.title,
                                                      fontSize: 8,
                                                      color: const Color(
                                                        AppColors
                                                            .colorNameSpecialization,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.02,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 10,
                                          child: StyleBtnHeader(
                                            width: DEVICE_WIDTH * 0.00068,
                                            height: 0.05,
                                            size: controller.sizeTextSelected,
                                            textBtn: 'view_prescriptions'.tr,
                                            onPressed: () {
                                              change.goToComponentHeader.value =
                                                  'ContentPrescription';
                                              change.update();
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // start radiology
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.heHasExperienceIn.map((
                                  String e,
                                ) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DEVICE_HEIGHT * 0.005,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: DEVICE_WIDTH * 0.01,
                                          height: DEVICE_HEIGHT * 0.005,
                                          color: const Color(
                                            AppColors.colorNameSpecialization,
                                          ),
                                        ),
                                        SizedBox(width: DEVICE_WIDTH * 0.025),
                                        Expanded(
                                          child: CustomText(
                                            text: e,
                                            fontSize: 12,
                                            type: CustomTextType.button,
                                            color: const Color(
                                              AppColors.colorNameSpecialization,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              SizedBox(
                                height: DEVICE_HEIGHT * 0.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.doctors.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 0.5,
                                          color: const Color(
                                            AppColors.colorWhiteSelectedType,
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom: DEVICE_HEIGHT * 0.02,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsGeometry.symmetric(
                                                  horizontal: 15,
                                                  vertical: 25,
                                                ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            10,
                                                          ),
                                                      child: Image.asset(
                                                        controller
                                                            .doctors[index]['image'],
                                                        width:
                                                            DEVICE_WIDTH * 0.16,
                                                        height:
                                                            DEVICE_HEIGHT *
                                                            0.09,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          DEVICE_WIDTH * 0.06,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CustomText(
                                                          text: controller
                                                              .doctors[index]['name']
                                                              .toString()
                                                              .tr,
                                                          type: CustomTextType
                                                              .title,
                                                          fontSize: 13,
                                                          color: const Color(
                                                            AppColors
                                                                .colorTitle,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              DEVICE_HEIGHT *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            CustomText(
                                                              text: controller
                                                                  .doctors[index]['specialization'],
                                                              type: CustomTextType
                                                                  .inputTitle,
                                                              fontSize: 10,
                                                              color: const Color(
                                                                AppColors
                                                                    .colorNameSpecialization,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.015,
                                                            ),
                                                            CustomText(
                                                              text: controller
                                                                  .doctors[index]['range'],
                                                              type: CustomTextType
                                                                  .inputTitle,
                                                              fontSize: 10,
                                                              color: const Color(
                                                                AppColors
                                                                    .colorSelectDropDown,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.008,
                                                            ),
                                                            SvgPicture.asset(
                                                              iconStar,
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.025,
                                                              height:
                                                                  DEVICE_HEIGHT *
                                                                  0.015,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.02,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.015,
                                                ),
                                                CustomText(
                                                  text: controller
                                                      .doctors[index]['date_revelation'],
                                                  type: CustomTextType.title,
                                                  fontSize: 8,
                                                  color: const Color(
                                                    AppColors
                                                        .colorNameSpecialization,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.010,
                                                ),
                                                CustomText(
                                                  text: 'situation'.tr,
                                                  type: CustomTextType.title,
                                                  fontSize: 8,
                                                  color: const Color(
                                                    AppColors.colorTitleDoppler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 20,
                                          child: Column(
                                            children: <Widget>[
                                              StyleBtnHeader(
                                                width: DEVICE_WIDTH * 0.00088,
                                                height: 0.05,
                                                size:
                                                    controller.sizeTextSelected,
                                                textBtn: 'x_ray_results'.tr,
                                                onPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color(
                                                      AppColors
                                                          .colorLineAndText,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: StyleBtnHeader(
                                                  color: const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              DEVICE_WIDTH *
                                                              0.01,
                                                        ),
                                                    backgroundColor: const Color(
                                                      AppColors
                                                          .colorWhiteSelectedType,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                  width: DEVICE_WIDTH * 0.00088,
                                                  height: 0.05,
                                                  size: controller
                                                      .sizeTextSelected,
                                                  textBtn:
                                                      'view_prescriptions'.tr,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //start analyses
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.heHasExperienceIn.map((
                                  String e,
                                ) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DEVICE_HEIGHT * 0.005,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: DEVICE_WIDTH * 0.01,
                                          height: DEVICE_HEIGHT * 0.005,
                                          color: const Color(
                                            AppColors.colorNameSpecialization,
                                          ),
                                        ),
                                        SizedBox(width: DEVICE_WIDTH * 0.025),
                                        Expanded(
                                          child: CustomText(
                                            text: e,
                                            fontSize: 12,
                                            type: CustomTextType.button,
                                            color: const Color(
                                              AppColors.colorNameSpecialization,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: DEVICE_WIDTH * 0.055,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: DEVICE_HEIGHT * 0.012),
                              SizedBox(
                                height: DEVICE_HEIGHT * 0.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.doctors.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 0.5,
                                          color: const Color(
                                            AppColors.colorWhiteSelectedType,
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom: DEVICE_HEIGHT * 0.02,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsGeometry.symmetric(
                                                  horizontal: 15,
                                                  vertical: 25,
                                                ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            10,
                                                          ),
                                                      child: Image.asset(
                                                        controller
                                                            .doctors[index]['image'],
                                                        width:
                                                            DEVICE_WIDTH * 0.16,
                                                        height:
                                                            DEVICE_HEIGHT *
                                                            0.09,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          DEVICE_WIDTH * 0.06,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        CustomText(
                                                          text: controller
                                                              .doctors[index]['name']
                                                              .toString()
                                                              .tr,
                                                          type: CustomTextType
                                                              .title,
                                                          fontSize: 13,
                                                          color: const Color(
                                                            AppColors
                                                                .colorTitle,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              DEVICE_HEIGHT *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            CustomText(
                                                              text: controller
                                                                  .doctors[index]['specialization'],
                                                              type: CustomTextType
                                                                  .inputTitle,
                                                              fontSize: 10,
                                                              color: const Color(
                                                                AppColors
                                                                    .colorNameSpecialization,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.015,
                                                            ),
                                                            CustomText(
                                                              text: controller
                                                                  .doctors[index]['range'],
                                                              type: CustomTextType
                                                                  .inputTitle,
                                                              fontSize: 10,
                                                              color: const Color(
                                                                AppColors
                                                                    .colorSelectDropDown,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.008,
                                                            ),
                                                            SvgPicture.asset(
                                                              iconStar,
                                                              width:
                                                                  DEVICE_WIDTH *
                                                                  0.025,
                                                              height:
                                                                  DEVICE_HEIGHT *
                                                                  0.015,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          DEVICE_HEIGHT * 0.02,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.015,
                                                ),
                                                CustomText(
                                                  text: controller
                                                      .doctors[index]['date_revelation'],
                                                  type: CustomTextType.title,
                                                  fontSize: 8,
                                                  color: const Color(
                                                    AppColors
                                                        .colorNameSpecialization,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: DEVICE_HEIGHT * 0.010,
                                                ),
                                                CustomText(
                                                  text: 'situation'.tr,
                                                  type: CustomTextType.title,
                                                  fontSize: 8,
                                                  color: const Color(
                                                    AppColors.colorTitleDoppler,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 20,
                                          child: Column(
                                            children: <Widget>[
                                              StyleBtnHeader(
                                                width: DEVICE_WIDTH * 0.00088,
                                                height: 0.05,
                                                size:
                                                    controller.sizeTextSelected,
                                                textBtn: 'x_ray_results'.tr,
                                                onPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color(
                                                      AppColors
                                                          .colorLineAndText,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: StyleBtnHeader(
                                                  color: const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              DEVICE_WIDTH *
                                                              0.01,
                                                        ),
                                                    backgroundColor: const Color(
                                                      AppColors
                                                          .colorWhiteSelectedType,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                  width: DEVICE_WIDTH * 0.00088,
                                                  height: 0.05,
                                                  size: controller
                                                      .sizeTextSelected,
                                                  textBtn:
                                                      'view_prescriptions'.tr,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
