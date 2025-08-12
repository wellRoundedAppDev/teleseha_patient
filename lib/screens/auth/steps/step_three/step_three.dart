import '../../../../general_exports.dart';

class StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: DEVICE_WIDTH * 0.03),
              child: CustomeInput(
                title: 'name'.tr,
                hint: 'name_field'.tr,
                controller: controller.textFieldName,
                showVaildMessage: controller.showNameError,
                textIsVaild: 'is_vaild_name_field'.tr,
                width_container: 0.90,
                colorLabel: AppColors.colorLineAndText,
                text_input_type: TextInputType.text,
                icon: false,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: CustomeInput(
                    onTap: () {
                      controller.pickDate(context);
                    },
                    readOnly: true,
                    title: 'date_age'.tr,
                    hint: 'enter_date_age'.tr,
                    controller: controller.dateController,
                    showVaildMessage: controller.showdateControllerError,
                    textIsVaild: 'is_vaild_enter_age'.tr,
                    width_container: 0.40,
                    colorLabel: AppColors.colorLineAndText,
                    text_input_type: TextInputType.text,
                    name_icon_field: iconDate,
                  ),
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
                        fontSize: 20,
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
                                  color:
                                      controller.selectedMaleCode == item[code]
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
                                                AppColors
                                                    .colorwhiteSelectedType,
                                              )
                                            : Color(
                                                AppColors.colorselectDropDown,
                                              ),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.04),
                                    SvgPicture.asset(
                                      item[icon] ?? '',
                                      color:
                                          controller.selectedMaleCode ==
                                              item[code]
                                          ? Color(
                                              AppColors.colorwhiteSelectedType,
                                            )
                                          : Color(
                                              AppColors.colorselectDropDown,
                                            ),
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
                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                    IsVailds(is_vaild_text: ''.tr),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
