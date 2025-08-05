import '../../general_exports.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    required this.child,
    this.color,
    this.onTap,
    this.boxShadow,
    this.minHeight = 0.1,
    this.borderRadius = 0.08,
    this.borderWidth = 0.0,
    this.borderColor = AppColors.transparent,
    this.withPadding = true,
    this.minWidth,
    super.key,
  });

  final Color? color;
  final Widget child;
  final Function()? onTap;
  final double minHeight;
  final BoxShadow? boxShadow;
  final bool withPadding;
  final double borderRadius;
  final double borderWidth;
  final int borderColor;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?.call,
      child: Container(
        constraints: BoxConstraints(
          minHeight: DEVICE_WIDTH * minHeight,
          minWidth: minWidth ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DEVICE_WIDTH * borderRadius),
          color: color ?? const Color(AppColors.grey),
          border: Border.all(
            color: Color(borderColor),
            width: borderWidth,
          ),
          boxShadow: boxShadow == null
              ? null
              : <BoxShadow>[
                  boxShadow!,
                ],
        ),
        padding: withPadding
            ? EdgeInsets.symmetric(
                horizontal: DEVICE_WIDTH * 0.034,
              )
            : null,
        child: child,
      ),
    );
  }
}
