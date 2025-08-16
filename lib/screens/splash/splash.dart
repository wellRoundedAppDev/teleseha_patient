import '../../general_exports.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('ss'),
      // body: GetBuilder<SplashController>(
      //   init: SplashController(),
      //   builder: (SplashController controller) {
      //     return Container(
      //       child: Text("loading Splash..."),
      //       alignment: Alignment.center,
      //       color: const Color(AppColors.grey),
      //       height: DEVICE_HEIGHT,
      //       width: DEVICE_WIDTH,
      //     );
      //   },
      // ),
    );
  }
}
