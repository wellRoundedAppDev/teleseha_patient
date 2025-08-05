import '../../general_exports.dart';

class SignInSheet extends StatelessWidget {
  const SignInSheet({super.key, this.successAction});

  MyAppController get myAppController => Get.find<MyAppController>();
  final Function()? successAction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('can_login_by_enter_phone'.tr),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(minHeight: DEVICE_HEIGHT * 0.055),
                  width: DEVICE_WIDTH * 0.17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(AppColors.grey),
                    borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.01),
                  ),
                  child: Text(
                    '+966',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
                Expanded(
                  child: CustomInput(
                    controller: myAppController.phoneController,
                    hint: '5xx xxx xxx',
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.05),
          SizedBox(
            width: DEVICE_WIDTH,
            child: CustomButton(
              text: 'login'.tr,
              onPressed: myAppController.preSignIn,
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          SizedBox(
            width: DEVICE_WIDTH,
            child: ElevatedButton(
              onPressed: () {
                myAppController.openSignUpSheet();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                ),
                side: const BorderSide(color: Color(AppColors.grey)),
                backgroundColor: const Color(AppColors.transparent),
              ),
              child: Text(
                'create_new_account'.tr,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: const Color(AppColors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
        ],
      ),
    );
  }
}
