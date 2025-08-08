import '../../general_exports.dart';

class StepOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'age'.tr,
              style: TextStyle(
                color: Color(AppColors.colorLineAndText),
                fontWeight: FontWeight.w400,
                fontFamily: 'Cairo',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            Container(
              width: DEVICE_WIDTH * 0.40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(88, 189, 189, 189),
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: GetBuilder<PassTypeAndAge>(
                builder: (controller) {
                  return TextFormField(
                    controller: controller.Textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      hintText: 'enterAge'.tr,
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(
                          AppColors.colorHintText,
                        ).withValues(alpha: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(width: DEVICE_WIDTH * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'type'.tr,
              style: TextStyle(
                color: Color(AppColors.colorLineAndText),
                fontWeight: FontWeight.w400,
                fontFamily: 'Cairo',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.02),
            GetBuilder<PassTypeAndAge>(
              builder: (controller) {
                return Row(
                  children: controller.type.map<Widget>((item) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.changeType(item['gender']);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selected == item['gender']
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
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
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item['gender'] ?? '',
                                  style: TextStyle(
                                    color: controller.selected == item['gender']
                                        ? Color(AppColors.colorWhite)
                                        : Color(AppColors.colorLineAndText),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.04),
                                SvgPicture.asset(
                                  item['icon'] ?? '',
                                  color: controller.selected == item['gender']
                                      ? Color(AppColors.colorWhite)
                                      : Color(AppColors.colorselectDropDown),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: DEVICE_WIDTH * 0.04),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
