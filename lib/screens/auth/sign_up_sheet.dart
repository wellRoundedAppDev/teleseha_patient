import '../../general_exports.dart';

class SignUpSheet extends StatelessWidget {
  const SignUpSheet({super.key, this.successAction});

  final Function()? successAction;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppController>(
      init: Get.find<MyAppController>(),
      builder: (MyAppController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('create_new_account_by_phone_number'.tr),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          SizedBox(
            width: DEVICE_WIDTH * 0.55,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    onTap: () {
                      controller.onCompanyIndividualPress(value: 'individual');
                    },
                    borderColor: !controller.isCompanySelected
                        ? AppColors.grey
                        : AppColors.grey,
                    color: Color(
                      !controller.isCompanySelected
                          ? AppColors.grey
                          : AppColors.grey,
                    ),
                    child: Center(
                      child: Text(
                        'individual'.tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: !controller.isCompanySelected
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
                Expanded(
                  child: RoundedContainer(
                    onTap: () {
                      controller.onCompanyIndividualPress();
                    },
                    borderColor: controller.isCompanySelected
                        ? AppColors.grey
                        : AppColors.grey,
                    color: Color(
                      controller.isCompanySelected
                          ? AppColors.grey
                          : AppColors.grey,
                    ),
                    child: Center(
                      child: Text(
                        'company'.tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: controller.isCompanySelected
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          if (!controller.isCompanySelected)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomInput(
                  controller: controller.firstNameController,
                  hint: 'first_name'.tr,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                CustomInput(
                  controller: controller.lastNameController,
                  hint: 'last_name'.tr,
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomInput(
                  controller: controller.companyArNameController,
                  hint: 'company_name_ar'.tr,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                CustomInput(
                  controller: controller.companyEnNameController,
                  hint: 'company_name_en'.tr,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                CustomInput(
                  controller: controller.companyRegistrationNumber,
                  hint: 'commercial_registration_no'.tr,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                CustomInput(
                  controller: controller.companyEmail,
                  hint: 'email_address'.tr,
                ),
              ],
            ),
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
                    controller: controller.phoneController,
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
              text: 'create'.tr,
              onPressed: controller.preSignUp,
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.02),
          SizedBox(
            width: DEVICE_WIDTH,
            child: ElevatedButton(
              onPressed: () {
                controller.openSignInSheet(action: successAction);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                ),
                side: const BorderSide(color: Color(AppColors.grey)),
                backgroundColor: const Color(AppColors.transparent),
              ),
              child: Text(
                'back_to_login'.tr,
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
