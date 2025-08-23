import '../../general_exports.dart';

class StyleBtnHeader extends StatelessWidget {
  StyleBtnHeader({super.key, this.textBtn, this.onPressed});

  String? textBtn;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DEVICE_HEIGHT * 0.042,
      width: DEVICE_WIDTH * 0.2,
      child: ElevatedButton(
        onPressed: () {
          onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(AppColors.colorLineAndText),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: CustomText(
          text: textBtn,
          fontSize: 8,
          type: CustomTextType.title,
          color: const Color(AppColors.colorWhiteSelectedType),
        ),
      ),
    );
  }
}
