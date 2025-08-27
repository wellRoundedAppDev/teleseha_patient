import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class SuccessReception extends StatelessWidget {
  SuccessReception({
    super.key,
    this.receptionTextStatus = true,
    this.specializationSelected,
    this.textBtn,
    this.onPressed,
  });

  bool? receptionTextStatus;
  String? specializationSelected;
  String? textBtn;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceptionController>(
      init: ReceptionController(),
      builder: (ReceptionController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.015),
            if (receptionTextStatus ?? true)
              CustomText(
                text: 'reception'.tr,
                fontSize: 20,
                type: CustomTextType.title,
                color: const Color(AppColors.colorLineAndText),
              )
            else
              const SizedBox(),
            SizedBox(height: DEVICE_HEIGHT * 0.11),
            Column(
              children: <Widget>[
                SvgPicture.asset(
                  successMark,
                  width: DEVICE_WIDTH * 0.135,
                  height: DEVICE_HEIGHT * 0.135,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
                CustomText(
                  text: specializationSelected,
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.08),
                Btn(
                  onPressed: () {
                    onPressed?.call();
                  },
                  text: textBtn,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
