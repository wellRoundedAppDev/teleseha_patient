import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class ContentReception extends StatelessWidget {
  const ContentReception({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();

    return GetBuilder<ReceptionController>(
      init: ReceptionController(),
      builder: (ReceptionController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.015),
            CustomText(
              text: 'reception'.tr,
              fontSize: 20,
              type: CustomTextType.title,
              color: const Color(AppColors.colorLineAndText),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.065),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: DEVICE_WIDTH * 0.56,
                    height: DEVICE_HEIGHT * 0.22,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(164, 0, 123, 189),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: DEVICE_WIDTH * 0.16,
                                height: DEVICE_WIDTH * 0.16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white.withOpacity(
                                    0.2,
                                  ),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                ),
                              ),
                              SvgPicture.asset(
                                iconDoctors,
                                width: DEVICE_WIDTH * 0.035,
                                height: DEVICE_HEIGHT * 0.035,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.012),
                          CustomText(
                            text: '[${controller.formattedTime}]',
                            fontSize: 20,
                            type: CustomTextType.title,
                            color: const Color(
                              AppColors.colorWhiteSelectedType,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.04),
                CustomText(
                  text: 'analysis_underway'.tr,
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.008),
                CustomText(
                  text: 'please_wait'.tr,
                  fontSize: 11,
                  type: CustomTextType.title,
                  color: const Color.fromARGB(175, 51, 51, 51),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.04),
                Btn(
                  onPressed: () {
                    change.goToComponentStatusBar.value = 'successReception';
                    change.update();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(83, 0, 123, 189),
                    padding: EdgeInsets.symmetric(
                      vertical: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                  text: 'wait'.tr,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
