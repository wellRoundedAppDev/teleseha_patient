import '../../general_exports.dart';

class Btn extends StatelessWidget {
  const Btn({
    super.key,
    this.text,
    this.color,
    this.onPressed,
    this.style,
    this.width = 0.9,
    this.size = 20
  });

  final String? text;
  final Color? color;
  final Function? onPressed;
  final ButtonStyle? style;
  final double? width;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * width!,
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
          fontSize: size,
          color: const Color(AppColors.colorWhiteSelectedType),
        ),
      ),
    );
  }
}
