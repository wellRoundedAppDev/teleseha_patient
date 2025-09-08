import '../../general_exports.dart';

class StyleBtnHeader extends StatelessWidget {
  StyleBtnHeader({
    super.key,
    this.textBtn,
    this.onPressed,
    this.width = 0.21,
    this.height = 0.042,
    this.size = 8,
  });

  String? textBtn;
  Function? onPressed;
  double? width;
  double? height;
  double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DEVICE_HEIGHT * height!,
      width: DEVICE_WIDTH * width!,
      child: ElevatedButton(
        onPressed: () {
          onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.01),
          backgroundColor: const Color(AppColors.colorLineAndText),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: CustomText(
          text: textBtn,
          fontSize: size!,
          type: CustomTextType.title,
          color: const Color(AppColors.colorWhiteSelectedType),
        ),
      ),
    );
  }
}
