import 'package:flutter_svg/flutter_svg.dart';
import '../../general_exports.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconLogo,
      width: DEVICE_WIDTH * 0.09,
      height: DEVICE_HEIGHT * 0.09,
      fit: BoxFit.cover,
    );
  }
}
