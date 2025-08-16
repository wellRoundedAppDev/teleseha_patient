import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class DiagnosisRecipient extends StatelessWidget {
  const DiagnosisRecipient({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiagnosisRecipientController>(
      init: DiagnosisRecipientController(),
      builder: (DiagnosisRecipientController controller) {
        return Scaffold(
          body: Container(
            width: DEVICE_WIDTH,
            margin: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.11),
            child: Column(
              children: <Widget>[
                const Logo(),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
                CustomText(
                  text: 'how_diagnosis'.tr,
                  fontSize: 22,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorTextBlue),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: always_specify_types
                  children: List.generate(controller.typeDiagnosis.length, (
                    int index,
                  ) {
                    final Map<String, String> item =
                        controller.typeDiagnosis[index];
                    final bool isLast =
                        index == controller.typeDiagnosis.length - 1;
                    final bool isActive =
                        controller.isMyChildrenSelected == item[code];
                    return Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            controller.changeTypeDiagnosis(item[code]!);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: DEVICE_WIDTH * 0.325,
                            height: DEVICE_HEIGHT * 0.15,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(AppColors.colorLineAndText)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: <BoxShadow>[
                                const BoxShadow(
                                  color: Color.fromARGB(88, 189, 189, 189),
                                  blurRadius: 5,
                                ),
                              ],
                              border: Border.all(
                                color: isActive
                                    ? Colors.transparent
                                    : const Color(AppColors.colorGrey),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  item[icon]!,
                                  width: DEVICE_WIDTH * 0.05,
                                  height: DEVICE_HEIGHT * 0.05,
                                  fit: BoxFit.cover,
                                  // ignore: deprecated_member_use
                                  color: isActive ? Colors.white : Colors.black,
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.02),
                                CustomText(
                                  text: item[about]!,
                                  fontSize: 16,
                                  type: CustomTextType.button,
                                  color:
                                      controller.isMyChildrenSelected ==
                                          item[code]
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLast) SizedBox(width: DEVICE_WIDTH * 0.1),
                      ],
                    );
                  }),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.04),
                Btn(
                  text: 'next'.tr,
                  color: const Color(AppColors.colorLineAndText),
                  onPressed: () {
                    controller.howDiagnosis();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
