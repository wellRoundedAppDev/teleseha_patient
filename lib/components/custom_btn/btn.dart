import '../../general_exports.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    this.text,
    this.color,
    this.onPressed,
    this.style,
    this.colorText,
  });

  final String? text;
  final Color? color;
  final Function? onPressed;
  final ButtonStyle? style;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * 0.9,
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
        child: CustomText(
          text: text,
          type: CustomTextType.button,
          fontSize: 20,
          color: colorText ?? const Color(AppColors.colorWhiteSelectedType),
        ),
      ),
    );
  }
}
