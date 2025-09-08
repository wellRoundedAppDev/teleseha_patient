import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.13),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomText(
                  text: 'notifications'.tr,
                  fontSize: 18,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.02),
                SvgPicture.asset(
                  iconNotification,
                  width: 24,
                  height: 26,
                  color: const Color(AppColors.colorLineAndText),
                ),
              ],              
            ),
            ListView()
          ],
        ),
      ),
    );
  }
}
