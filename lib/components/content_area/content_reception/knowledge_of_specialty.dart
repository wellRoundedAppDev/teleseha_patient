import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class KnowledgeOfSpecialty extends StatelessWidget {
  const KnowledgeOfSpecialty({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    final HomePageContentController homePage = Get.find();

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
                      border: Border.all(
                        color: const Color(AppColors.colorSymptomsBorder),
                      ),
                      color: const Color.fromARGB(118, 253, 253, 253),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
                          blurRadius: 20,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            iconHeart,
                            width: DEVICE_WIDTH * 0.08,
                            height: DEVICE_HEIGHT * 0.08,
                          ),
                          CustomText(
                            text: '${'Specialization_is'.tr} ${'heart'.tr}',
                            fontSize: 20,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorSelectDropDown),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.033),
                CustomText(
                  text: 'please_booking'.tr,
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.065),
                Btn(
                  onPressed: () {
                    change.goToComponentHeader.value = 'HomePage';
                    homePage.checkReservations = true;
                    homePage.update();
                    change.update();
                  },
                  text: 'selected_doctor'.tr,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
