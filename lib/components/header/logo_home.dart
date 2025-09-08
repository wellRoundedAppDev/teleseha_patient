import 'package:flutter_svg/svg.dart';
import '../../general_exports.dart';

class LogoHome extends StatelessWidget {
  const LogoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconLogoSeha,
      width: DEVICE_WIDTH * 0.06,
      height: DEVICE_HEIGHT * 0.06,
    );
  }
}
