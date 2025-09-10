import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              iconBack,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
              color: Colors.black,
            ),
          ),
          SvgPicture.asset(
            iconLogoLogin,
            width: 142,
            height: 44,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
