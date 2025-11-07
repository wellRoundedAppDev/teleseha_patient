import '../../../general_exports.dart';

class ChatGemini extends StatelessWidget {
  ChatGemini({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatGeminiController>(
      init: ChatGeminiController(),
      builder: (ChatGeminiController controller) {
        return SizedBox(
          height: DEVICE_HEIGHT * 0.75,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DEVICE_HEIGHT * 0.015,
              vertical: DEVICE_WIDTH * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  text: 'your_condition'.tr,
                  fontSize: 18,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.01),
                if (controller.isLoading)
                  const CircularProgressIndicator()
                else
                  Container(
                    height: DEVICE_HEIGHT * 0.3,
                    child: ListView.builder(
                      itemCount: controller.myBodyValue.length,
                      itemBuilder: (BuildContext context, int index) {
                        // ignore: always_specify_types
                        final item = controller.myBodyValue[index];
                        final String question = item['content'] ?? '';
                        final List<dynamic> choices =
                            item['choicesList'] ?? <dynamic>[];

                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: DEVICE_HEIGHT * 0.008,
                          ),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.all(
                                    DEVICE_HEIGHT * 0.012,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      AppColors.colorLineAndText,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CustomText(
                                    text: question,
                                    fontSize: 12,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorWhiteSelectedType,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.015),
                              // ignore: always_specify_types
                              ...choices.map((choice) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: DEVICE_HEIGHT * 0.006,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DEVICE_WIDTH * 0.02,
                                      vertical: DEVICE_HEIGHT * 0.004,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        AppColors.colorWhiteSelectedType,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          // ignore: deprecated_member_use
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: IntrinsicWidth(
                                      child: RadioListTile<String>(
                                        value: choice,
                                        // ignore: deprecated_member_use
                                        groupValue: controller.selectedChoice,
                                        // ignore: deprecated_member_use
                                        onChanged: (String? value) {
                                          controller.selectedChoice = value;
                                          controller.update();
                                        },
                                        title: CustomText(
                                          text: choice,
                                          fontSize: 10,
                                          color: const Color(
                                            AppColors.colorSelectDropDown,
                                          ),
                                        ),
                                        activeColor: Colors.white,
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: DEVICE_HEIGHT * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomText(
                          text: 'answer'.tr,
                          fontSize: 18,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                        CustomInput(
                          hint: 'write_answer'.tr,
                          controller: controller.writeAnswer,
                          showValidMessage: controller.showWriteAnswer,
                          widthContainer: DEVICE_WIDTH,
                          fontSize: 14,
                          colorLabel: AppColors.colorLineAndText,
                          keyboardType: TextInputType.text,
                          sizespace: 0,
                          paddingVertical: 0.037,
                        ),
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.005),
                    Btn(
                      isLoading: controller.isLoadingGemini,
                      onPressed: () {
                        controller.isGemeini();
                      },
                      text: 'next'.tr,
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
