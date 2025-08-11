import '../../general_exports.dart';

class IsVailds extends StatelessWidget {
  IsVailds({super.key, this.is_vaild_text});

  String? is_vaild_text;

  @override
  Widget build(BuildContext context) {
    return Text(
      is_vaild_text!,
      style: TextStyle(
        color: Color(AppColors.colorError),
        fontSize: 12,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
