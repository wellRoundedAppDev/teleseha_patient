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
              children: [
                const Logo(),
                SizedBox(height: DEVICE_HEIGHT * 0.1),
                Text(
                  'how_diagnosis'.tr,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(AppColors.colorTextBlue),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.04),
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
                      children: [
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
                              boxShadow: [
                                const BoxShadow(
                                  color: Color.fromARGB(
                                    88,
                                    189,
                                    189,
                                    189,
                                  ),
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
                              children: [
                                SvgPicture.asset(
                                  item[icon]!,
                                  width: DEVICE_WIDTH * 0.05,
                                  height: DEVICE_HEIGHT * 0.05,
                                  fit: BoxFit.cover,
                                  color: isActive ? Colors.white : Colors.black,
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.02),
                                Text(
                                  item[about]!,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        controller.isMyChildrenSelected ==
                                            item[code]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
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
                    controller.isMyChildrenSelected == 'aboutMe'
                        ? Get.toNamed(routeFormDiagnosis)
                        : Get.toNamed(routeSelectTypeChildren);
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
