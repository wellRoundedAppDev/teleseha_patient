import '../../general_exports.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      init: HomePageContentController(),
      builder: (HomePageContentController controller) {
        return Scaffold(
          backgroundColor: const Color(AppColors.colorLineAndText),
          body: Column(
            children: <Widget>[
              StatusBar(goToComponentStatusBar: 'HomePage'),
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              ContentArea(goToComponentContentArea: 'HomePage',),
            ],
          ),
        );
      },
    );
  }
}
