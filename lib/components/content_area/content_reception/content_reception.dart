import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class ContentReception extends StatelessWidget {
  const ContentReception({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceptionController>(
      init: ReceptionController(),
      builder: (ReceptionController controller) {
        final ChangeParamContentAndNextPage change = Get.find();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.045),
            CustomText(
              text: 'reception'.tr,
              fontSize: 20,
              type: CustomTextType.title,
              color: const Color(AppColors.colorLineAndText),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.095),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: DEVICE_WIDTH * 0.64,
                    height: DEVICE_HEIGHT * 0.27,
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
                              if (controller.isTimeUp)
                                const SizedBox()
                              else
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.06),
                CustomText(
                  text: 'analysis_underway'.tr,
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.008),
                CustomText(
                  text:
                      'please_wait2'.tr +
                      controller.formattedTime +
                      'please_wait1'.tr,
                  fontSize: 10,
                  type: CustomTextType.title,
                  color: const Color.fromARGB(175, 51, 51, 51),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.055),
                Btn(
                  customHeight: 0.075,
                  onPressed: controller.isTimeUp
                      ? () {
                          change.goToComponentHeader.value = 'successReception';
                          change.update();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isTimeUp
                        ? const Color(AppColors.colorLineAndText)
                        : Colors.blue.withOpacity(0.3),
                    padding: EdgeInsets.symmetric(
                      vertical: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                  text: controller.isTimeUp ? 'next'.tr : 'wait'.tr,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
