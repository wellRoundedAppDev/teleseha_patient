import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

// ignore: camel_case_types
class FormDataUser extends StatelessWidget {
  FormDataUser({required this.isFromProfile, super.key});
  final bool isFromProfile;

  LoginController login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (StartStepsController controller) {
        return isFromProfile
            ? Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DEVICE_WIDTH * 0.035,
                  ),
                  child: CustomInput(
                    title: 'name'.tr,
                    hint: 'name_field'.tr,
                    controller: controller.textFieldName,
                    showValidMessage: controller.showNameError,
                    textIsValid: 'is_valid_name_field'.tr,
                    widthContainer: 0.90,
                    fontSize: 20,
                    colorLabel: AppColors.colorLineAndText,
                    keyboardType: TextInputType.text,
                    bottomSpacing: DEVICE_HEIGHT * 0.0,
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.022),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 1, right: 18),
                      child: CustomInput(
                        onTap: () {
                          controller.pickDate(context);
                        },
                        readOnly: true,
                        title: 'date_age'.tr,
                        hint: 'enter_date_age'.tr,
                        controller: controller.dateController,
                        showValidMessage:
                            controller.showdateControllerError,
                        textIsValid: 'is_valid_enter_age'.tr,
                        widthContainer: 0.38,
                        fontSize: 20,
                        sizespace: 0.019,
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
                          // fontWeight: FontWeight.w400,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.019),
                        Row(
                          children: controller.typeGenerate.map<Widget>((
                            Map<String, String> item,
                          ) {
                            return Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    controller.changeTypeGenerate(
                                      item[code]!,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedMaleCode ==
                                              item[code]
                                          ? const Color(
                                              AppColors.colorLineAndText,
                                            )
                                          : const Color(
                                              AppColors
                                                  .colorWhiteSelectedType,
                                            ),
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DEVICE_WIDTH * 0.028,
                                      vertical: DEVICE_HEIGHT * 0.021,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        CustomText(
                                          text: item[gender] ?? '',
                                          type: CustomTextType.title,
                                          // fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color:
                                              controller.selectedMaleCode ==
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
                                        SizedBox(
                                          width: DEVICE_WIDTH * 0.04,
                                        ),
                                        SvgPicture.asset(
                                          item[icon] ?? '',
                                          // ignore: deprecated_member_use
                                          color:
                                              controller.selectedMaleCode ==
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
            )
            : GetBuilder<StartStepsController>(
                init: StartStepsController(),
                builder: (StartStepsController controller) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
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
                          backgroundColor: Colors.transparent,
                          title: SizedBox(
                            width: DEVICE_WIDTH * 0.425,
                            height: DEVICE_HEIGHT * 0.0108,
                            child: LinearProgressIndicator(
                              value: controller.currentStep == 1
                                  ? 0.4
                                  : controller.currentStep == 2
                                  ? 0.6
                                  : 1,
                              borderRadius: BorderRadius.circular(15),
                              backgroundColor:
                                  controller.currentStep !=
                                      controller.numberOfStep
                                  ? const Color(AppColors.backgroundColorLine)
                                  : const Color(AppColors.colorSuccessLine),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(
                                  AppColors.colorLineAndText,
                                ).withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                          centerTitle: true,
                        ),
                      ),
                    ),
                    body: login.profiles.isNotEmpty
                        ? UserFormFields(
                            controller: controller,
                            context: context,
                          )
                        : Scaffold(
                            resizeToAvoidBottomInset: false,
                            body: Column(
                              children: <Widget>[
                                SizedBox(height: DEVICE_HEIGHT * 0.012),
                                // const Logo(),
                                if (controller.currentStep == 1) ...<Widget>[
                                  SizedBox(height: DEVICE_HEIGHT * 0.043),
                                  UserFormFields(
                                    controller: controller,
                                    context: context,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.067),
                                  StepIndicator(
                                    currentStep: controller.currentStep,
                                    totalSteps: controller.numberOfStep,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.035),
                                ] else if (controller.currentStep ==
                                    2) ...<Widget>[
                                  SizedBox(height: DEVICE_HEIGHT * 0.053),
                                  UserFormFields(
                                    controller: controller,
                                    context: context,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.067),
                                  StepIndicator(
                                    currentStep: controller.currentStep,
                                    totalSteps: controller.numberOfStep,
                                  ),
                                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                                ] else
                                  const Text('test'),
                            
                                if (controller.currentStep <
                                    controller.numberOfStep)
                                  Btn(
                                    onPressed: () {
                                      controller.onNextButtonPress();
                                    },
                                    text: 'next'.tr,
                                  ),
                              ],
                            ),
                          ),
                  );
                },
              );
      },
    );
  }
}

class UserFormFields extends StatelessWidget {
  const UserFormFields({
    required this.controller,
    required this.context,
    super.key,
  });
  final StartStepsController controller;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.035),
          child: CustomInput(
            title: 'name'.tr,
            hint: 'name_field'.tr,
            controller: controller.textFieldName,
            showValidMessage: controller.showNameError,
            textIsValid: 'is_valid_name_field'.tr,
            widthContainer: 0.90,
            fontSize: 20,
            colorLabel: AppColors.colorLineAndText,
            keyboardType: TextInputType.text,
            bottomSpacing: DEVICE_HEIGHT * 0.0,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.022),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 1, right: 18),
              child: CustomInput(
                onTap: () => controller.pickDate(context),
                readOnly: true,
                title: 'date_age'.tr,
                hint: 'enter_date_age'.tr,
                controller: controller.dateController,
                showValidMessage: controller.showdateControllerError,
                textIsValid: 'is_valid_enter_age'.tr,
                widthContainer: 0.38,
                fontSize: 20,
                sizespace: 0.019,
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
                  // fontWeight: FontWeight.w400,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.019),
                Row(
                  children: controller.typeGenerate.map<Widget>((
                    Map<String, String> item,
                  ) {
                    return Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () =>
                              controller.changeTypeGenerate(item[code]!),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedMaleCode == item[code]
                                  ? const Color(AppColors.colorLineAndText)
                                  : const Color(
                                      AppColors.colorWhiteSelectedType,
                                    ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(88, 189, 189, 189),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: DEVICE_WIDTH * 0.028,
                              vertical: DEVICE_HEIGHT * 0.021,
                            ),
                            child: Row(
                              children: <Widget>[
                                CustomText(
                                  text: item[gender] ?? '',
                                  type: CustomTextType.title,
                                  // fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color:
                                      controller.selectedMaleCode == item[code]
                                      ? const Color(
                                          AppColors.colorWhiteSelectedType,
                                        )
                                      : const Color(
                                          AppColors.colorSelectDropDown,
                                        ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.04),
                                SvgPicture.asset(
                                  item[icon] ?? '',
                                  // ignore: deprecated_member_use
                                  color:
                                      controller.selectedMaleCode == item[code]
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
  }
}
