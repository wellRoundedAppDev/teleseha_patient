import '../../general_exports.dart';

class Btn extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function? onPressed;
  final ButtonStyle? style;

  const Btn({this.text, this.color, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DEVICE_WIDTH * 0.9,
      child: ElevatedButton(
        style:
            style ??
            ElevatedButton.styleFrom(
              backgroundColor: color ?? Color(AppColors.colorLineAndText),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.02),
            ),
        onPressed: () {
          onPressed?.call();
        },
        child: Text(
          text ?? '',
          style: TextStyle(
            color: Color(AppColors.colorWhite),
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
