import '../../general_exports.dart';

class CusomeForm extends StatelessWidget {
  const CusomeForm({
    required super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.isVaild,
    required this.textIsVaild,
    this.width_container = 0.85,
    required this.colorLabel,
    required this.text_input_type,
    this.icon = true,
    this.name_icon_field,
    this.between_field_bottom = 0.02,
    this.fontSize = 18,
  });

  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final bool isVaild;
  final String? textIsVaild;
  final double width_container;
  final int colorLabel;
  final TextInputType text_input_type;
  final bool icon;
  final String? name_icon_field;
  final double between_field_bottom;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            color: Color(colorLabel),
            fontWeight: FontWeight.w400,
            fontFamily: 'Cairo',
            fontSize: fontSize,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Container(
          width: DEVICE_WIDTH * width_container,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(AppColors.colorWhite)),
          ),
          child: TextFormField(
            keyboardType: text_input_type,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: icon
                  ? SizedBox(
                      width: DEVICE_WIDTH * 0.1,
                      child: Center(
                        child: SvgPicture.asset(
                          name_icon_field!,
                          width: DEVICE_WIDTH * 0.02,
                          height: DEVICE_HEIGHT * 0.02,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Text(''),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              hintText: hintText ?? '',
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(AppColors.colorHintText).withValues(alpha: 20),
              ),
            ),
          ),
        ),
        isVaild
            ? SizedBox(height: DEVICE_HEIGHT * 0.01)
            : SizedBox(height: DEVICE_HEIGHT * 0),
        isVaild
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
        SizedBox(height: DEVICE_HEIGHT * between_field_bottom),
      ],
    );
  }
}
