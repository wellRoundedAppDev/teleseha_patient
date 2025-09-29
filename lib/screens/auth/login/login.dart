import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: DEVICE_HEIGHT * 0.1),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    iconLogoLogin,
                    width: 142,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.12),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: DEVICE_HEIGHT * 0.035,
                    horizontal: DEVICE_HEIGHT * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: DEVICE_HEIGHT * 0.014),
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
                                SizedBox(height: DEVICE_HEIGHT * 0.053),
                                CustomInput(
                                  title: 'number_phone'.tr,
                                  hint: 'number_phone_field'.tr,
                                  controller: controller.phoneNumberController,
                                  showValidMessage:
                                      controller.showPhoneNumberError,
                                  textIsValid: controller.phoneErrorMessage,
                                  // 'is_valid_number'.tr
                                  colorLabel: AppColors.colorLabel,
                                  keyboardType: TextInputType.phone,
                                  suffixIconPath: iconNumber,
                                  bottomSpacing: DEVICE_HEIGHT * 0.0,
                                  sizespace: DEVICE_HEIGHT * 0.000018,
                                ),
                              ],
                            ),
                            SizedBox(height: DEVICE_HEIGHT * 0.046),
                            Btn(
                              text: 'next'.tr,
                              onPressed: controller.handleLogin,
                              isLoading: controller.isLoading,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
