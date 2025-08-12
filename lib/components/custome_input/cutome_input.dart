import '../../general_exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomeInput extends StatelessWidget {
  const CustomeInput({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.showVaildMessage,
    this.textIsVaild,
    this.widthContainer = 0.85,
    this.colorLabel,
    this.keyboardType,
    this.icon,
    this.suffixIconPath,
    this.bottomSpacing = 0.02,
    this.fontSize = 18,
    this.readOnly = false,
    this.onTap,
  });

  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final bool? showVaildMessage;
  final String? textIsVaild;
  final double widthContainer;
  final int? colorLabel;
  final TextInputType? keyboardType;
  final String? icon;
  final String? suffixIconPath;
  final double bottomSpacing;
  final double fontSize;
  final bool readOnly;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            color: Color(colorLabel!),
            fontWeight: FontWeight.w400,
            fontFamily: 'Cairo',
            fontSize: fontSize,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Container(
          width: DEVICE_WIDTH * widthContainer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(AppColors.colorWhite)),
          ),
          child: TextFormField(
            onTap: () {
              onTap?.call();
            },
            readOnly: readOnly,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffixIconPath != null
                  ? SizedBox(
                      width: DEVICE_WIDTH * 0.1,
                      child: Center(
                        child: SvgPicture.asset(
                          suffixIconPath!,
                          width: DEVICE_WIDTH * 0.02,
                          height: DEVICE_HEIGHT * 0.02,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(AppColors.colorHintText).withValues(alpha: 20),
              ),
            ),
          ),
        ),
        showVaildMessage!
            ? SizedBox(height: DEVICE_HEIGHT * 0.018)
            : SizedBox(height: DEVICE_HEIGHT * 0),
        showVaildMessage!
            ? Text(
                textIsVaild!,
                style: TextStyle(
                  color: Color(AppColors.colorError),
                  fontSize: 11,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              )
            : Text(
                '',
                style: TextStyle(
                  color: Color(AppColors.colorError),
                  fontSize: 11,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
        SizedBox(height: DEVICE_HEIGHT * bottomSpacing),
      ],
    );
  }
}
