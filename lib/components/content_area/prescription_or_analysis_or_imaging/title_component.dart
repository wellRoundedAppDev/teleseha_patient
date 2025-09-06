import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class TitleComponent extends StatelessWidget {
   TitleComponent({super.key, this.title});

  String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(
          text: title,
          fontSize: 18,
          type: CustomTextType.title,
          color: const Color(AppColors.colorTextBlue),
        ),
        SizedBox(width: DEVICE_WIDTH * 0.02),
        SvgPicture.asset(
          iconCard,
          width: DEVICE_WIDTH * 0.04,
          height: DEVICE_HEIGHT * 0.03,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
