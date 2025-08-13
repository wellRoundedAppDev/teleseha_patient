import '../../general_exports.dart';

class IsValid extends StatelessWidget {
  IsValid({super.key, this.isValidText});

  String? isValidText;

  @override
  Widget build(BuildContext context) {
    return Text(
      isValidText!,
      style: const TextStyle(
        color: Color(AppColors.colorError),
        fontSize: 11,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
