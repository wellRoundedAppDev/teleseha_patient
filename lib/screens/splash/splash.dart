import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setIsRTL(context);

    return Scaffold(
      backgroundColor: const Color(AppColors.white),
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (SplashController controller) {
          return Container(
            alignment: Alignment.center,
            color: const Color(
              AppColors.primary,
            ),
            height: DEVICE_HEIGHT,
            width: DEVICE_WIDTH,
            child: SvgPicture.asset(
              iconLogo,
            ),
          );
        },
      ),
    );
  }
}
