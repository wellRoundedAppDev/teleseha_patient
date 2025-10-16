import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class Logo extends StatelessWidget {
  Logo({super.key, this.controllerBack = true});

  // MedicalHistoryController medicalHistoryController = Get.put(
  //   MedicalHistoryController(),
  // );

  final bool controllerBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DEVICE_WIDTH * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (controllerBack == true) {
                consoleLog('true');
                Get.back();
              } else {
                // medicalHistoryController.prevMedicalProfileSection();
              }
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
