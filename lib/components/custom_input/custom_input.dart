import 'package:flutter_svg/flutter_svg.dart';

import '../../general_exports.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.showValidMessage,
    this.textIsValid,
    this.widthContainer = 0.85,
    this.colorLabel,
    this.keyboardType,
    this.icon,
    this.suffixIconPath,
    this.bottomSpacing = 0.02,
    this.fontSize = 16,
    this.readOnly = false,
    this.onTap,
    this.sizespace = 0.021,
    this.paddingVertical = 0.051,
    this.textType = CustomTextType.inputTitle,
    this.onSuffixIconTap,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final bool? showValidMessage;
  final String? textIsValid;
  final double widthContainer;
  final int? colorLabel;
  final TextInputType? keyboardType;
  final String? icon;
  final String? suffixIconPath;
  final double bottomSpacing;
  final double fontSize;
  final bool readOnly;
  final Function? onTap;
  final double? sizespace;
  final double paddingVertical;
  final CustomTextType textType;
  final VoidCallback? onSuffixIconTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
          text: title,
          type: textType,
          fontSize: fontSize,
          color: Color(colorLabel!),
        ),
        SizedBox(height: DEVICE_HEIGHT * sizespace!),
        Container(
          width: DEVICE_WIDTH * widthContainer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(AppColors.colorWhite),
              width: 0.8,
            ),
          ),
          child: TextFormField(
            scrollPadding: const EdgeInsets.only(bottom: 150),
            keyboardAppearance: Brightness.light,
            onTap: () {
              onTap?.call();
            },
            readOnly: readOnly,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffixIconPath != null
                  ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: SizedBox(
                        width: DEVICE_WIDTH * 0.1,
                        child: Center(
                          child: SvgPicture.asset(
                            suffixIconPath!,
                            width: DEVICE_WIDTH * 0.02,
                            height: DEVICE_HEIGHT * 0.02,
                          ),
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DEVICE_HEIGHT * 0.024,
                vertical: DEVICE_WIDTH * paddingVertical,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: const Color(
                  AppColors.colorHintText,
                ).withValues(alpha: 20),
              ),
            ),
          ),
        ),
        // if (showValidMessage!) SizedBox(height: DEVICE_HEIGHT * 0.0115),
        // if (showValidMessage!)
        //   CustomText(
        //     text: textIsValid!,
        //     type: CustomTextType.title,
        //     fontSize: 11,
        //     color: const Color(AppColors.colorError),
        //   ),
        SizedBox(height: DEVICE_HEIGHT * bottomSpacing),
      ],
    );
  }
}
