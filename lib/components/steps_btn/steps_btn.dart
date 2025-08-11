import '../../general_exports.dart';

class StepsBtn extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function? onPressed;

  const StepsBtn({super.key, this.onPressed, this.text, this.color});

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
          onPressed?.call();
        },
        child: Text(
          text ?? '',
          style: TextStyle(
            color: Color(AppColors.colorwhiteSelectedType),
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
