import '../../../../general_exports.dart';

class StepTow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      builder: (controller) {
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
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.TextfieldAge,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      hintText: 'enter_age'.tr,
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(
                          AppColors.colorHintText,
                        ).withValues(alpha: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.01),
                controller.isVaildAge
                    ? IsVailds(is_vaild_text: 'is_vaild_enter_age'.tr)
                    : Text(''),
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
                Row(
                  children: controller.typeGenrate.map<Widget>((item) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.changeTypeGenrate(item[code]!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedMaleCode == item[code]
                                  ? Color(AppColors.colorLineAndText)
                                  : Color(AppColors.colorwhiteSelectedType),
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
                                  item[gender] ?? '',
                                  style: TextStyle(
                                    color:
                                        controller.selectedMaleCode ==
                                            item[code]
                                        ? Color(
                                            AppColors.colorwhiteSelectedType,
                                          )
                                        : Color(AppColors.colorselectDropDown),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.04),
                                SvgPicture.asset(
                                  item[icon] ?? '',
                                  color:
                                      controller.selectedMaleCode == item[code]
                                      ? Color(AppColors.colorwhiteSelectedType)
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
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.01),
                Text(''),
              ],
            ),
          ],
        );
      },
    );
  }
}
