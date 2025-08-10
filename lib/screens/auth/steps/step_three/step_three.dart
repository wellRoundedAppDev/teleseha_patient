import '../../../../general_exports.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartStepsController>(
      init: StartStepsController(),
      builder: (controller) {
        controller.secondsRemaining == 70 && controller.timer == null
            ? controller.startCountdown()
            : null;
        return Column(
          children: [
            Text(
              'medical_history'.tr,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(AppColors.colorTextBlue),
              ),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.06),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'number_phone'.tr,
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
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.TextfieldNumber,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      suffixIcon: SizedBox(
                        width: DEVICE_WIDTH * 0.1,
                        child: Center(
                          child: SvgPicture.asset(
                            iconNumber,
                            width: DEVICE_WIDTH * 0.02,
                            height: DEVICE_HEIGHT * 0.02,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      hintText: 'number_phone_field'.tr,
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
              ],
            ),
          ],
        );
      },
    );
  }
}
