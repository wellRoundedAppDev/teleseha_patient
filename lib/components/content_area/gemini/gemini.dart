import '../../../general_exports.dart';

class Gemini extends StatelessWidget {
  const Gemini({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeminiController>(
      init: GeminiController(),
      builder: (GeminiController controller) {
        final ChangeParamContentAndNextPage change = Get.find();
        return SingleChildScrollView(
          child: Column(
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
                  CustomInput(
                    title: 'write_your_offer'.tr,
                    hint: 'write_your_symptoms_to_determine_specialty'.tr,
                    controller: controller.writeYourOffer,
                    showValidMessage: controller.showwriteYourOfferError,
                    widthContainer: DEVICE_WIDTH,
                    textType: CustomTextType.title,
                    colorLabel: AppColors.colorLineAndText,
                    keyboardType: TextInputType.text,
                    paddingVertical: 0.037,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.055),
                  Btn(
                    onPressed: controller.isInputNotEmpty
                        ? () {
                            change.goToComponentHeader.value = 'Reception';
                            change.update();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isInputNotEmpty
                          ? const Color(AppColors.colorLineAndText)
                          // ignore: deprecated_member_use
                          : Colors.blue.withOpacity(0.3),
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.02,
                      ),
                    ),
                    text: 'send'.tr,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
