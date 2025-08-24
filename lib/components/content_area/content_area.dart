import '../../general_exports.dart';

class ContentArea extends StatelessWidget {
  ContentArea({super.key, this.goToComponentContentArea});

  String? goToComponentContentArea;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.045,
          vertical: DEVICE_HEIGHT * 0.028,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          color: Color(AppColors.backgroundColorLine),
        ),
        width: DEVICE_WIDTH,
        child: goToComponentContentArea == 'HomePage'
            ? ContentHome()
            : goToComponentContentArea == 'Symptoms'
            ? const ContentSymptoms()
            : ContentDoctors(),
      ),
    );
  }
}
