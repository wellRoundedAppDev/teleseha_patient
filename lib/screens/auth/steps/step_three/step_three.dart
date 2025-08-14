import 'package:flutter_svg/flutter_svg.dart';

import '../../../../general_exports.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: DEVICE_WIDTH * 0.03),
              child: CustomInput(
                title: 'name'.tr,
                hint: 'name_field'.tr,
                controller: controller.textFieldName,
                showValidMessage: controller.showNameError,
                textIsValid: 'is_valid_name_field'.tr,
                widthContainer: 0.90,
                colorLabel: AppColors.colorLineAndText,
                keyboardType: TextInputType.text,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: CustomInput(
                    onTap: () {
                      controller.pickDate(context);
                    },
                    readOnly: true,
                    title: 'date_age'.tr,
                    hint: 'enter_date_age'.tr,
                    controller: controller.dateController,
                    showValidMessage: controller.showdateControllerError,
                    textIsValid: 'is_valid_enter_age'.tr,
                    widthContainer: 0.40,
                    colorLabel: AppColors.colorLineAndText,
                    keyboardType: TextInputType.text,
                    suffixIconPath: iconDate,
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: 'type'.tr,
                      type: CustomTextType.title,
                      fontWeight: FontWeight.w400,
                      color: const Color(AppColors.colorLineAndText),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                    Row(
                      children: controller.typeGenerate.map<Widget>((
                        Map<String, String> item,
                      ) {
                        return Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                controller.changeTypeGenerate(item[code]!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedMaleCode == item[code]
                                      ? const Color(AppColors.colorLineAndText)
                                      : const Color(
                                          AppColors.colorWhiteSelectedType,
                                        ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    const BoxShadow(
                                      color: Color.fromARGB(88, 189, 189, 189),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 20,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      item[gender] ?? '',
                                      style: TextStyle(
                                        color:
                                            controller.selectedMaleCode ==
                                                item[code]
                                            ? const Color(
                                                AppColors
                                                    .colorWhiteSelectedType,
                                              )
                                            : const Color(
                                                AppColors.colorSelectDropDown,
                                              ),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.04),
                                    SvgPicture.asset(
                                      item[icon] ?? '',
                                      // ignore: deprecated_member_use
                                      color:
                                          controller.selectedMaleCode ==
                                              item[code]
                                          ? const Color(
                                              AppColors.colorWhiteSelectedType,
                                            )
                                          : const Color(
                                              AppColors.colorSelectDropDown,
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
                    IsValid(isValidText: ''.tr),
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
