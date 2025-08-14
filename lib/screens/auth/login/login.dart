import 'package:flutter/gestures.dart';

import '../../../general_exports.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.12,
              horizontal: DEVICE_HEIGHT * 0.02,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.03),
                  CustomText(
                    text: 'login'.tr,
                    fontSize: 24,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: DEVICE_HEIGHT * 0.06),
                          CustomInput(
                            title: 'number_phone'.tr,
                            hint: 'number_phone_field'.tr,
                            controller: controller.textFieldPhoneNumber,
                            showValidMessage: controller.showPhoneNumberError,
                            textIsValid: 'is_valid_number'.tr,
                            widthContainer: 0.90,
                            colorLabel: AppColors.colorLabel,
                            keyboardType: TextInputType.number,
                            suffixIconPath: iconNumber,
                            bottomSpacing: DEVICE_HEIGHT * 0.0,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.015),
                          Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '${'not_have_account'.tr} ',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(AppColors.colorReset),
                                  ),
                                ),
                                TextSpan(
                                  text: 'create_account'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(
                                      AppColors.colorTextBlue,
                                    ).withAlpha(160),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(routeSteps);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.031),
                      StepsBtn(
                        onPressed: () {
                          controller.handleLogin();
                        },
                        text: 'next'.tr,
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
