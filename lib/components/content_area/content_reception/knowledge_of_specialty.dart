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
            SizedBox(height: DEVICE_HEIGHT * 0.1),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: DEVICE_WIDTH * 0.6,
                    height: DEVICE_HEIGHT * 0.28,
                    decoration: BoxDecoration(
                      // border: 1px solid rgba(218, 218, 218, 0.57);
                      border: Border.all(
                        color: const Color.fromRGBO(218, 218, 218, 0.57),
                      ),
                      color: const Color.fromRGBO(0, 123, 189, 0.02),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        const BoxShadow(
                          color: Color.fromRGBO(218, 218, 218, 0.50),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: const Color.fromRGBO(
                                  218,
                                  218,
                                  218,
                                  0.57,
                                ),
                              ),
                            ),
                            child: SvgPicture.asset(
                              iconHeart,
                              width: DEVICE_WIDTH * 0.08,
                              height: DEVICE_HEIGHT * 0.08,
                            ),
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
                SizedBox(height: DEVICE_HEIGHT * 0.043),
                CustomText(
                  text: 'please_booking'.tr,
                  fontSize: 14,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.095),
                Btn(
                  
                  onPressed: () {
                    change.goToComponentHeader.value = 'HomePage';
                    // homePage.checkReservations = true;
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
