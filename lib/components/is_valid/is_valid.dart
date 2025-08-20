import '../../general_exports.dart';

class IsValid extends StatelessWidget {
  IsValid({super.key, this.isValidText});

  String? isValidText;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: isValidText!,
      type: CustomTextType.button,
      color: const Color(AppColors.colorError),
    );
  }
}
