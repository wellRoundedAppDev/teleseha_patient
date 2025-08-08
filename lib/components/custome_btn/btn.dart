import '../../general_exports.dart';

class Btn extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final bool Function()? checkVaildType;
  final VoidCallback? onNext;
  final String? text;
  final Color? color;

  const Btn({
    super.key,
    this.formKey,
    this.checkVaildType,
    this.onNext,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DEVICE_WIDTH * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(AppColors.colorLineAndText),
          padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.02),
        ),
        onPressed: () {
          final isFormValid = formKey?.currentState?.validate() ?? true;
          final isCustomValid = checkVaildType?.call() ?? true;
          if (isFormValid && isCustomValid) {
            onNext?.call();
          }
        },
        child: Text(
          text ?? '',
          style: TextStyle(
            color: Color(AppColors.colorWhite),
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
