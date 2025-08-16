import '../../general_exports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.colorLineAndText),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (HomeController controller) {
          return Column(
            children: <Widget>[
              const StatusBar(),
              SizedBox(height: DEVICE_HEIGHT * 0.025),
              const ContentArea(),
            ],
          );
        },
      ),
    );
  }
}
