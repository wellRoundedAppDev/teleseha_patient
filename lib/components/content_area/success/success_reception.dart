import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class SuccessReception extends StatelessWidget {
  SuccessReception({
    super.key,
    this.receptionTextStatus = true,
    this.titleSpecializationSelected,
    this.textSpecializationSelected,
    this.textBtn,
    this.onPressed,
  });

  bool? receptionTextStatus;
  String? titleSpecializationSelected;
  String? textSpecializationSelected;
  String? textBtn;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceptionController>(
      init: ReceptionController(),
      builder: (ReceptionController controller) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Column(
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
                    text: titleSpecializationSelected,
                    fontSize: 16,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorLineAndText),
                  ),
                  const SizedBox(height: 11),
                  CustomText(
                    text: textSpecializationSelected,
                    fontSize: 13,
                    type: CustomTextType.title,
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.055),
                  Btn(
                    onPressed: () {
                      onPressed?.call();
                    },
                    text: textBtn,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
