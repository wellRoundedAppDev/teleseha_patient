import 'package:flutter_svg/flutter_svg.dart';

import '../../../../general_exports.dart';

class TypeChildren extends StatelessWidget {
  const TypeChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TypeController>(
      init: TypeController(),
      builder: (TypeController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                backgroundColor: Colors.transparent,
                leading: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      iconBack,
                      width: DEVICE_WIDTH * 0.04,
                      height: DEVICE_HEIGHT * 0.02,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.03,
              horizontal: DEVICE_WIDTH * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 6),
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
                          widthContainer: 0.3,
                          colorLabel: AppColors.colorLineAndText,
                          keyboardType: TextInputType.text,
                          suffixIconPath: iconDate,
                        ),
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'type'.tr,
                            style: const TextStyle(
                              color: Color(AppColors.colorLineAndText),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Cairo',
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                          Row(
                            children: controller.typeChildrenGender.map<Widget>((
                              Map<String, String> item,
                            ) {
                              return Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      controller.changeTypeChildrenGender(
                                        item[code]!,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedTypChildren ==
                                                item[code]
                                            ? const Color(
                                                AppColors.colorLineAndText,
                                              )
                                            : const Color(
                                                AppColors
                                                    .colorWhiteSelectedType,
                                              ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: <BoxShadow>[
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
                                                  controller
                                                          .selectedTypChildren ==
                                                      item[code]
                                                  ? const Color(
                                                      AppColors
                                                          .colorWhiteSelectedType,
                                                    )
                                                  : const Color(
                                                      AppColors
                                                          .colorSelectDropDown,
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
                                                controller
                                                        .selectedTypChildren ==
                                                    item[code]
                                                ? const Color(
                                                    AppColors
                                                        .colorWhiteSelectedType,
                                                  )
                                                : const Color(
                                                    AppColors
                                                        .colorSelectDropDown,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.03),
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
                  CustomInput(
                    title: 'name'.tr,
                    hint: 'name_field'.tr,
                    controller: controller.textFieldName,
                    showValidMessage: controller.showNameError,
                    textIsValid: 'is_valid_name_field'.tr,
                    widthContainer: 0.88,
                    colorLabel: AppColors.colorLineAndText,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.02),
                  Btn(
                    text: 'next'.tr,
                    color: const Color(AppColors.colorLineAndText),
                    onPressed: () {
                      if (controller.checkValidTypeChildren()) {
                        Get.toNamed(routeFormDiagnosis);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
