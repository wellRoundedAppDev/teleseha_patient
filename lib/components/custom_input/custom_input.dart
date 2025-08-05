import '../../general_exports.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.fillColor = AppColors.grey,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.validator,
    this.initialValue,
    this.hintStyle,
    this.onFieldSubmitted,
    this.maxLines,
    this.readOnly = false,
  });

  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int fillColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function? onChange;
  final Function? onFieldSubmitted;
  final int? borderColor;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextStyle? hintStyle;
  final int? maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      cursorColor: const Color(AppColors.grey),
      initialValue: initialValue,
      onChanged: (String value) {
        onChange?.call(value);
      },
      onFieldSubmitted: (String value) {
        onFieldSubmitted?.call(value);
      },
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(AppColors.grey),
          ),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hint,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.04,
          vertical: DEVICE_HEIGHT * 0.015,
        ),
        fillColor: Color(fillColor),
        filled: true,
        enabledBorder: _getInputBorder(),
        focusedBorder: _getInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  InputBorder _getInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(
          borderColor ?? fillColor,
        ),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(DEVICE_WIDTH * 0.015),
      ),
    );
  }
}
