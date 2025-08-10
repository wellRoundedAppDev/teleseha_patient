import 'package:patient/screens/auth/diagnosis_recipient/diagnosis_recipient_controller.dart';
import '../../../general_exports.dart';

class DiagnosisRecipient extends StatelessWidget {
  const DiagnosisRecipient({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiagnsisRecipientController>(
      init: DiagnsisRecipientController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: DEVICE_WIDTH,
            margin: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.11),
            child: Column(
              children: [
                Logo(),
                SizedBox(height: DEVICE_HEIGHT * 0.1),
                Text(
                  'how_diagnosis'.tr,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(AppColors.colorTextBlue),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.typeDiagnosis.length, (
                    index,
                  ) {
                    final item = controller.typeDiagnosis[index];
                    final isLast = index == controller.typeDiagnosis.length - 1;
                    final isActive =
                        controller.isMyChildrenSelected == item[code];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.changeTypeDiagnosis(item[code]!);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: DEVICE_WIDTH * 0.325,
                            height: DEVICE_HEIGHT * 0.15,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Color(AppColors.colorLineAndText)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    88,
                                    189,
                                    189,
                                    189,
                                  ),
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              border: Border.all(
                                color: isActive
                                    ? Colors.transparent
                                    : Color(AppColors.grey),
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
                  color: Color(AppColors.colorLineAndText),
                  onPressed: () {
                    controller.isMyChildrenSelected == 'aboutMe'
                        ? Get.toNamed(routeAuth)
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
