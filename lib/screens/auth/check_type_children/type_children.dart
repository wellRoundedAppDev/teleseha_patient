import 'package:patient/components/steps_btn/steps_btn.dart';

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
                leading: controller.selectedSteps != 1
                    ? InkWell(
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
                      )
                    : Text(''),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: controller.selectedSteps != 3
                  ? DEVICE_HEIGHT * 0.03
                  : DEVICE_HEIGHT * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.1),
                  Form(
                    child: Column(
                      children: [
                        Row(
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
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.TextfieldAgeChildren,
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
                                  ),
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.01),
                                controller.viewAgeChildrenInvalid
                                    ? Text(
                                        'الرجاء ادخال العمر',
                                        style: TextStyle(
                                          color: Color(AppColors.colorError),
                                          fontSize: 16,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : Text(''),
                              ],
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
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(height: DEVICE_HEIGHT * 0.02),
                                Row(
                                  children: controller.TypeChildren.map<Widget>((
                                    item,
                                  ) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.changeTypeChildren(
                                              item['gender'],
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  controller
                                                          .selectedTypChildren ==
                                                      item['gender']
                                                  ? Color(
                                                      AppColors
                                                          .colorLineAndText,
                                                    )
                                                  : Color(
                                                      AppColors
                                                          .colorwhiteSelectedType,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                    color:
                                                        controller
                                                                .selectedTypChildren ==
                                                            item['gender']
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
                                                  item['icon'] ?? '',
                                                  color:
                                                      controller
                                                              .selectedTypChildren ==
                                                          item['gender']
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
                                SizedBox(height: DEVICE_HEIGHT * 0.01),
                                controller.viewVaildTypeChildren
                                    ? Text(
                                        'الرجاء اختيار النوع',
                                        style: TextStyle(
                                          color: Color(AppColors.colorError),
                                        ),
                                      )
                                    : Text(''),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'name'.tr,
                              style: TextStyle(
                                color: Color(AppColors.colorLineAndText),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.02),
                            Container(
                              width: DEVICE_WIDTH * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(AppColors.colorWhite),
                                ),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: controller.TextfieldNameChildren,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 20,
                                  ),
                                  hintText: 'namefield'.tr,
                                  hintStyle: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      AppColors.colorHintText,
                                    ).withValues(alpha: 20),
                                  ),
                                ),
                              ),
                            ),
                            controller.viewNameChildrenInvalid
                                ? Text(
                                    'الرجاء ادخال الاسم',
                                    style: TextStyle(
                                      color: Color(AppColors.colorError),
                                      fontSize: 16,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text(''),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 3 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 2 ? 1 : 6.5,
                            ),
                            SizedBox(width: DEVICE_HEIGHT * 0.01),
                            ContainerSteps(
                              MyAlpha: controller.selectedSteps == 1 ? 1 : 6.5,
                            ),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.03),
                        controller.selectedSteps != 3
                            ? StepsBtn(
                                onPressed: () {},
                                text: controller.selectedSteps == 3
                                    ? 'confirm'.tr
                                    : 'next'.tr,
                              )
                            : Btn(
                                text: 'next'.tr,
                                color: Color(AppColors.colorLineAndText),
                                onPressed: () {
                                  if (controller.checkVaildTypeChildren()) {
                                    Get.toNamed(routeSuccess);
                                  }
                                },
                              ),
                      ],
                    ),
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
