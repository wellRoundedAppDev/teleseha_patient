import '../../../general_exports.dart';

class DetailsAboutYou extends StatelessWidget {
  const DetailsAboutYou({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsAboutYouController>(
      init: DetailsAboutYouController(),
      builder: (DetailsAboutYouController controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.07),
              child: Column(
                children: <Widget>[
                  SizedBox(height: DEVICE_HEIGHT * 0.1),
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.055),
                  DetailsAboutYouComp(
                    title: 'country'.tr,
                    myListCountry: controller.countrys
                        // ignore: always_specify_types
                        .map<String>((e) => e['countryName'])
                        .toList(),
                    value: controller.selectedValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectedValue = newValue;
                        controller.update();
                      }
                    },
                    subTitle: 'enter_your_country'.tr,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  DetailsAboutYouComp(
                    title: 'country'.tr,
                    myListCountry: controller.countrys
                        // ignore: always_specify_types
                        .map<String>((e) => e['stateName'])
                        .toList(),
                    value: controller.selectedValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectedValue = newValue;
                        controller.update();
                      }
                    },
                    subTitle: 'enter_your_country'.tr,
                  ),
                  // DetailsAboutYouComp(
                  //   title: 'governorate'.tr,
                  //   // myListCountry: controller.listGovernorate,
                  //   // value: controller.selectedValueGovernorate,
                  //   onChanged: (String? newValue) {
                  //     if (newValue != null) {
                  //       // controller.updateSelectedGovernorate(newValue);
                  //     }
                  //   },
                  //   subTitle: 'enter_your_governorate'.tr,
                  // ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  DetailsAboutYouComp(
                    title: 'city'.tr,
                    // myListCountry: controller.listCity,
                    // value: controller.selectedCity,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // controller.updateSelectedCity(newValue);
                      }
                    },
                    subTitle: 'enter_your_city'.tr,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  DetailsAboutYouComp(
                    title: 'marital_status'.tr,
                    // myListCountry: controller.listsMaritalStatus,
                    // value: controller.maritalStatus,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // controller.updateSelectedMaritalStatus(newValue);
                      }
                    },
                    subTitle: 'enter_marital_status'.tr,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  CustomInput(
                    title: 'job_title'.tr,
                    hint: 'enter_job_title'.tr,
                    textType: CustomTextType.title,
                    controller: controller.jobTitle,
                    showValidMessage: controller.showjobTitleError,
                    textIsValid: controller.jobTitleErrorMessage,
                    colorLabel: AppColors.colorLabel,
                    keyboardType: TextInputType.text,
                    bottomSpacing: DEVICE_HEIGHT * 0.0,
                    sizespace: DEVICE_HEIGHT * 0.000028,
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Row(
                    children: <Widget>[
                      CustomInput(
                        title: 'length'.tr,
                        hint: 'enter_length'.tr,
                        textType: CustomTextType.title,
                        controller: controller.length,
                        showValidMessage: controller.showLengthError,
                        textIsValid: controller.lengthErrorMessage,
                        colorLabel: AppColors.colorLabel,
                        keyboardType: TextInputType.phone,
                        bottomSpacing: DEVICE_HEIGHT * 0.0,
                        widthContainer: 0.4,
                        sizespace: DEVICE_HEIGHT * 0.000028,
                      ),
                      SizedBox(width: DEVICE_WIDTH * 0.04),
                      CustomInput(
                        title: 'weight'.tr,
                        hint: 'enter_weight'.tr,
                        textType: CustomTextType.title,
                        controller: controller.weight,
                        showValidMessage: controller.showWeightError,
                        textIsValid: controller.weightMessage,
                        colorLabel: AppColors.colorLabel,
                        keyboardType: TextInputType.phone,
                        bottomSpacing: DEVICE_HEIGHT * 0.0,
                        widthContainer: 0.4,
                        sizespace: DEVICE_HEIGHT * 0.000028,
                      ),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.04),
                  Btn(text: 'next'.tr, onPressed: () {}),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
