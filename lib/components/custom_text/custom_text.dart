import '../../general_exports.dart';

enum CustomTextType { title, inputTitle, body, button }

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    super.key,
    this.type = CustomTextType.body,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight = FontWeight.w700,
  });

  final String? text;
  final CustomTextType type;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle;

    switch (type) {
      case CustomTextType.title:
        baseStyle = TextStyle(
          fontSize: 20,
          fontWeight: fontWeight,
          fontFamily: 'Cairo',
        );
        break;
      case CustomTextType.inputTitle:
        baseStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Cairo',
        );
        break;
      case CustomTextType.button:
        baseStyle = const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        );
        break;
      case CustomTextType.body:
        baseStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
        );
    }

    return Text(
      text ?? '',
      style: baseStyle.copyWith(
        fontSize: fontSize ?? baseStyle.fontSize,
        color: color ?? const Color(AppColors.colorTextBlue),
      ),
      textAlign: textAlign,
    );
  }
}
