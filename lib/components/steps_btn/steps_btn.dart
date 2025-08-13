import '../../general_exports.dart';

class StepsBtn extends StatelessWidget {
  const StepsBtn({super.key, this.onPressed, this.text, this.color});

  final String? text;
  final Color? color;
  final Function? onPressed;

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
          style: const TextStyle(
            color: Color(AppColors.colorWhiteSelectedType),
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
