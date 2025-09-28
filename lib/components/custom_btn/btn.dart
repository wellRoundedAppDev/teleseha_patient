import 'package:flutter_svg/flutter_svg.dart';
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
    this.customHeight = 0.075,
    this.size = 20,
    this.icon,
    this.isLoading = false,
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
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * customWidth!,
      height: DEVICE_HEIGHT * customHeight!,
      child: ElevatedButton(
        style:
            style ??
            ElevatedButton.styleFrom(
              backgroundColor: isLoading
                  ? const Color.fromARGB(96, 0, 123, 189)
                  : color ?? const Color(AppColors.colorLineAndText),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.02),
            ),
        onPressed: isLoading ? null : () => onPressed?.call(),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : icon != null
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
