import '../../general_exports.dart';

class Symptoms extends StatelessWidget {
  const Symptoms({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentSympotomsController>(
      init: ContentSympotomsController(),
      builder: (ContentSympotomsController controller) {
        return Scaffold(
          backgroundColor: const Color(AppColors.colorLineAndText),
          body: Column(
            children: <Widget>[
              StatusBar(goToComponentStatusBar: 'Symptoms'),
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              ContentArea(goToComponentContentArea: 'Symptoms'),
            ],
          ),
        );
      },
    );
  }
}
