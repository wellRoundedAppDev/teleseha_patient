import 'package:flutter_svg/svg.dart';

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
                Container(
                  height: DEVICE_HEIGHT * 0.3,
                  child: ListView.builder(
                    itemCount: controller.messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> message =
                          controller.messages[index];
                      final bool isMe = message['isMe'];

                      return Align(
                        alignment: isMe
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: DEVICE_HEIGHT * 0.008,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (!isMe)
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  width: DEVICE_WIDTH * 0.025,
                                  height: DEVICE_HEIGHT * 0.02,
                                ),
                              SizedBox(width: DEVICE_WIDTH * 0.01),
                              Container(
                                padding: EdgeInsets.all(DEVICE_HEIGHT * 0.012),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? const Color(AppColors.colorLineAndText)
                                      : const Color(AppColors.colorLineAndText),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  text: message['text'],
                                  fontSize: 12,
                                  type: CustomTextType.title,
                                  color: const Color(
                                    AppColors.colorWhiteSelectedType,
                                  ),
                                ),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.01),
                              if (isMe)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: DEVICE_WIDTH * 0.015,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/star.svg',
                                    width: DEVICE_WIDTH * 0.025,
                                    height: DEVICE_HEIGHT * 0.02,
                                  ),
                                ),
                            ],
                          ),
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
                          // controller: controller.filterDoctors,
                          // showValidMessage: controller.showDoctors,
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
                    Btn(onPressed: () {}, text: 'next'.tr),
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
