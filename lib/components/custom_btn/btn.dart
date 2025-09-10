import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    this.text,
    this.color,
    this.onPressed,
    this.style,
    this.colorText,
    this.customWidth = 0.9,
    this.customHeight = 0.1,
    this.size = 20,
    this.icon,
  });

  final String? text;
  final Color? color;
  final Function? onPressed;
  final ButtonStyle? style;
  final Color? colorText;
  final double? customWidth;
  final double? customHeight;
  final double? size;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * customWidth!,
      height: DEVICE_HEIGHT * customHeight!,
      child: ElevatedButton(
        style:
            style ??
            ElevatedButton.styleFrom(
              backgroundColor: color ?? const Color(AppColors.colorLineAndText),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.02),
            ),
        onPressed: () {
          onPressed?.call();
        },
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: text,
                    type: CustomTextType.button,
                    fontSize: size,
                    color:
                        colorText ??
                        const Color(AppColors.colorWhiteSelectedType),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  SvgPicture.asset(
                    iconDownload,
                    width: DEVICE_WIDTH * 0.015,
                    height: DEVICE_HEIGHT * 0.015,
                  ),
                ],
              )
            : CustomText(
                text: text,
                type: CustomTextType.button,
                fontSize: size,
                color:
                    colorText ?? const Color(AppColors.colorWhiteSelectedType),
              ),
      ),
    );
  }
}
