import '../../../general_exports.dart';

class TypeChildren extends StatelessWidget {
  const TypeChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TypeController>(
      init: TypeController(),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
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
            margin: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.01),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: DEVICE_HEIGHT * 0.02),
                  Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.06),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: CusomeForm(
                              title: 'age'.tr,
                              hintText: 'enter_age'.tr,
                              controller: controller.TextfieldAgeChildren,
                              isVaild: controller.isAgeChildrenInvalid,
                              textIsVaild: 'is_vaild_enter_age'.tr,
                              key: null,
                              width_container: 0.35,
                              colorLabel: AppColors.colorLineAndText,
                              text_input_type: TextInputType.number,
                              icon: false,
                            ),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'type'.tr,
                                style: TextStyle(
                                  color: Color(AppColors.colorLineAndText),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.02),
                              Row(
                                children: controller.TypeChildrenGender.map<Widget>((
                                  item,
                                ) {
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.changeTypeChildrenGender(
                                            item[code]!,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                controller
                                                        .selectedTypChildren ==
                                                    item[code]
                                                ? Color(
                                                    AppColors.colorLineAndText,
                                                  )
                                                : Color(
                                                    AppColors
                                                        .colorwhiteSelectedType,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
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
                                                      controller
                                                              .selectedTypChildren ==
                                                          item[code]
                                                      ? Color(
                                                          AppColors
                                                              .colorwhiteSelectedType,
                                                        )
                                                      : Color(
                                                          AppColors
                                                              .colorselectDropDown,
                                                        ),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(
                                                width: DEVICE_WIDTH * 0.04,
                                              ),
                                              SvgPicture.asset(
                                                item[icon] ?? '',
                                                color:
                                                    controller
                                                            .selectedTypChildren ==
                                                        item[code]
                                                    ? Color(
                                                        AppColors
                                                            .colorwhiteSelectedType,
                                                      )
                                                    : Color(
                                                        AppColors
                                                            .colorselectDropDown,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: DEVICE_WIDTH * 0.02),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CusomeForm(
                        title: 'name'.tr,
                        hintText: 'name_field'.tr,
                        controller: controller.TextfieldNameChildren,
                        isVaild: controller.isNameChildrenInvalid,
                        textIsVaild: 'is_vaild_enter_age'.tr,
                        key: null,
                        colorLabel: AppColors.colorLineAndText,
                        text_input_type: TextInputType.text,
                        icon: false,
                      ),
                      Btn(
                        text: 'next'.tr,
                        color: Color(AppColors.colorLineAndText),
                        onPressed: () {
                          if (controller.checkVaildTypeChildren()) {
                            // Get.toNamed(home);
                          }
                        },
                      ),
                    ],
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
