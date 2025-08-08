import '../../../general_exports.dart';

class StepTow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'name'.tr,
          style: TextStyle(
            color: Color(AppColors.colorLabel),
            fontWeight: FontWeight.w400,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Container(
          width: DEVICE_WIDTH * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(AppColors.colorWhite)),
          ),
          child: GetBuilder<PassTypeAndAge>(
            builder: (controller) {
              return TextFormField(
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == '') {
                    return 'الرجاء ادخال الاسم';
                  }
                  return null;
                },
                controller: controller.TextfieldName,
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
                    color: Color(AppColors.colorHintText).withValues(alpha: 20),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.03),
        Text(
          'numberPhone'.tr,
          style: TextStyle(
            color: Color(AppColors.colorLabel),
            fontWeight: FontWeight.w400,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Container(
          width: DEVICE_WIDTH * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(AppColors.colorWhite)),
          ),
          child: GetBuilder<PassTypeAndAge>(
            builder: (controller) {
              return TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == '') {
                    return 'الرجاء ادخال الرقم';
                  }
                  return null;
                },
                controller: controller.TextfieldNumber,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  hintText: 'numberPhoneField'.tr,
                  hintStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(AppColors.colorHintText).withValues(alpha: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
