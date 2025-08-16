import '../../../general_exports.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: AppBar(
                leading: const SizedBox(),
                backgroundColor: Colors.transparent,
                title: SizedBox(
                  width: DEVICE_WIDTH * 0.425,
                  height: DEVICE_HEIGHT * 0.0108,
                  child: LinearProgressIndicator(
                    value: 0.3,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: const Color(AppColors.backgroundColorLine),
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
          body: Container(
            margin: EdgeInsets.symmetric(
              vertical: DEVICE_HEIGHT * 0.035,
              horizontal: DEVICE_HEIGHT * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
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
                            controller: controller.textFieldPhoneNumber,
                            showValidMessage: controller.showPhoneNumberError,
                            textIsValid: 'is_valid_number'.tr,
                            colorLabel: AppColors.colorLabel,
                            keyboardType: TextInputType.number,
                            suffixIconPath: iconNumber,
                            bottomSpacing: DEVICE_HEIGHT * 0.0,
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.046),
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
