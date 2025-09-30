import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';
import 'title_component.dart';

class Analyses extends StatelessWidget {
  const Analyses(this.controller, this.ChangeContent, {super.key});
  final ListPresciption controller;
  // ignore: non_constant_identifier_names
  final RxString ChangeContent;

  @override
  Widget build(BuildContext context) {
    final BookingsController bookings = Get.find();

    return GetBuilder<ListPresciption>(
      builder: (ListPresciption controller) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TitleComponent(title: 'analyses'.tr),
              SizedBox(height: DEVICE_HEIGHT * 0.01),
              const CustomText(
                text: 'RX-20250824-00021',
                fontSize: 10,
                type: CustomTextType.title,
                color: Color.fromRGBO(0, 123, 189, 0.74),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.04),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(imageQr, width: 55, height: 55),
                  SizedBox(width: DEVICE_WIDTH * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          CustomText(
                            text: 'name_doctor'.tr,
                            fontSize: 13,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorTextBlue),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.01),
                          CustomText(
                            text: bookings.selectedLastRecent?['name']
                                .toString()
                                .tr,
                            fontSize: 10,
                            type: CustomTextType.title,
                            color: const Color.fromRGBO(0, 123, 189, 0.74),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.02),
                          SvgPicture.asset(
                            iconDoctors,
                            width: DEVICE_WIDTH * 0.035,
                            height: DEVICE_HEIGHT * 0.025,
                            fit: BoxFit.cover,
                            // ignore: deprecated_member_use
                            color: const Color.fromRGBO(0, 123, 189, 0.74),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          CustomText(
                            text: 'specialties'.tr,
                            fontSize: 13,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorTextBlue),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.01),
                          CustomText(
                            text: bookings.selectedLastRecent?['specialization']
                                .toString()
                                .tr,
                            fontSize: 10,
                            type: CustomTextType.title,
                            color: const Color.fromRGBO(0, 123, 189, 0.74),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          CustomText(
                            text: 'practicing_the_profession'.tr,
                            fontSize: 13,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorTextBlue),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.01),
                          const CustomText(
                            text: '9809809809',
                            fontSize: 10,
                            type: CustomTextType.title,
                            color: Color.fromRGBO(0, 123, 189, 0.74),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          CustomText(
                            text: 'name_patient'.tr,
                            fontSize: 13,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorTextBlue),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.01),
                          CustomText(
                            text: 'name_user'.tr,
                            fontSize: 10,
                            type: CustomTextType.title,
                            color: const Color.fromRGBO(0, 123, 189, 0.74),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.06),
              const Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: 'Lab Analysis Request',
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: Color(AppColors.colorTextBlue),
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.012),
              SizedBox(
                height: 210,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.radiologyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, String> item =
                        controller.radiologyList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text.rich(
                            TextSpan(
                              text: '${index + 1}. ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(AppColors.colorTextBlue),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(AppColors.colorTitleDoppler),
                                  ),
                                ),
                              ],
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.01),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Btn(
                    onPressed: () {
                      controller.savedPdf(
                        data: controller.radiologyList,
                        fileName: 'analyses',
                      );
                    },
                    text: 'download_the_analyses'.tr,
                    customWidth: 0.37,
                    size: 10,
                    icon: Icons.arrow_forward_ios,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppColors.colorLineAndText),
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.03,
                      ),
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.04),
                  Btn(
                    onPressed: () {
                      Get.offAllNamed(routeScreen);
                    },
                    text: 'home_page'.tr,
                    customWidth: 0.37,
                    size: 10,
                    colorText: const Color(AppColors.colorLineAndText),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        AppColors.colorWhiteSelectedType,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.1),
            ],
          ),
        );
      },
    );
  }
}
