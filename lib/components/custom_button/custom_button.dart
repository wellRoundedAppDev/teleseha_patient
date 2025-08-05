import '../../general_exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.backgroundColor,
    this.textColor,
  });

  final Function? onPressed;
  final String? text;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(AppColors.grey),
        padding: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.04,
          vertical: DEVICE_HEIGHT * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
        ),
      ),
      child: child ??
          Text(
            text ?? '',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: textColor ?? Colors.white,
                ),
          ),
    );
  }
}
