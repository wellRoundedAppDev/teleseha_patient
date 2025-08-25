import '../../../general_exports.dart';

class KnowledgeOfSpecialty extends StatelessWidget {
  const KnowledgeOfSpecialty({super.key});

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
                      color: const Color(AppColors.colorWhite),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: 'test',
                            fontSize: 20,
                            type: CustomTextType.title,
                            color: Color(AppColors.colorWhiteSelectedType),
                          ),
                          CustomText(
                            text: 'test',
                            fontSize: 20,
                            type: CustomTextType.title,
                            color: Color(AppColors.colorWhiteSelectedType),
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
