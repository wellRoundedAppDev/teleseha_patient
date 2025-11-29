import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../general_exports.dart';

Widget buildLogo() =>
    SvgPicture.asset(iconLogoLogin, width: 142, height: 44, fit: BoxFit.cover);

Widget buildLoginForm(LoginController controller, var context) => Container(
  margin: EdgeInsets.symmetric(
    vertical: DEVICE_HEIGHT * 0.035,
    horizontal: DEVICE_HEIGHT * 0.03,
  ),
  child: Column(
    children: <Widget>[
      SizedBox(height: DEVICE_HEIGHT * 0.014),
      CustomText(
        text: 'login'.tr,
        fontSize: 24,
        type: CustomTextType.title,
        color: const Color(AppColors.colorTextBlue),
      ),
      SizedBox(height: DEVICE_HEIGHT * 0.053),
      InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          // print(number.dialCode);
          //

          // print(number.phoneNumber);
          // print(controller.phoneNumberController.text);
          controller.setSelectedPhoneNumber(number.dialCode??"");
        },
        onInputValidated: (bool isValid) {
          print("Is valid? $isValid");
          controller.isValidPhoneNumber = isValid;
        //  controller.isPhoneValid.value = isValid;   // if using GetX
        },

        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,

       //   backgroundColor: Colors.black87,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.always,

        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue:PhoneNumber(
          isoCode: 'EG',
          dialCode: '+20',
        ),

        //initialValue: number,
        textFieldController: controller.phoneNumberController,
        formatInput: false,

      //   inputDecoration: InputDecoration(
      //
      //
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20),
      //       borderSide: BorderSide(width: 0.8,color: Colors.black),
      //
      //
      //       ),
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20),
      //   borderSide: const BorderSide(width: 0.8,
      //       color: Colors.black
      //   ),
      //
      // ),
      //     // suffixIcon: suffixIconPath != null
      //     //     ? GestureDetector(
      //     //   onTap: onSuffixIconTap,
      //     //   child: SizedBox(
      //     //     width: DEVICE_WIDTH * 0.1,
      //     //     child: Center(
      //     //       child: SvgPicture.asset(
      //     //         suffixIconPath!,
      //     //         width: DEVICE_WIDTH * 0.02,
      //     //         height: DEVICE_HEIGHT * 0.02,
      //     //       ),
      //     //     ),
      //     //   ),
      //     // )
      //     //     : null,
      //     border: InputBorder.none,
      //     contentPadding: EdgeInsets.symmetric(
      //       horizontal: DEVICE_HEIGHT * 0.024,
      //       vertical: 8,
      //     ),
      //     hintText: "hint",
      //     hintStyle: TextStyle(
      //       fontFamily: 'Cairo',
      //       fontSize: 14,
      //       fontStyle: FontStyle.normal,
      //       fontWeight: FontWeight.w400,
      //       color: const Color(
      //         AppColors.colorHintText,
      //       ).withValues(alpha: 20),
      //     ),
      //   ),

        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: const OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),
      // CustomInput(
      //   title: 'number_phone'.tr,
      //   hint: 'number_phone_field'.tr,
      //   controller: controller.phoneNumberController,
      //   showValidMessage: controller.showPhoneNumberError,
      //   textIsValid: controller.phoneErrorMessage,
      //   colorLabel: AppColors.colorLabel,
      //   keyboardType: TextInputType.phone,
      //   suffixIconPath: iconNumber,
      //   bottomSpacing: DEVICE_HEIGHT * 0.0,
      //   sizespace: DEVICE_HEIGHT * 0.000018,
      // ),
      SizedBox(height: DEVICE_HEIGHT * 0.046),
      Btn(
        text: 'next'.tr,
        onPressed: (){
          controller.handleLogin(context);
        },
        isLoading: controller.isLoading,
      ),
    ],
  ),
);

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
                buildLogo(),
                SizedBox(height: DEVICE_HEIGHT * 0.12),
                buildLoginForm(controller,context),
              ],
            ),
          ),
        );
      },
    );
  }
}
