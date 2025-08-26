import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ProfileDoctorStatusBar extends StatelessWidget {
  const ProfileDoctorStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    consoleLog('${change.selectedDoctorId}');
    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (DoctorsController controller) {
        return Container(
          width: DEVICE_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.07),
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  change.goToComponentStatusBar.value = 'Doctors';
                  change.update();
                },
                child: SvgPicture.asset(
                  iconArrow,
                  width: DEVICE_WIDTH * 0.034,
                  height: DEVICE_HEIGHT * 0.034,
                  fit: BoxFit.cover,
                ),
              ),
              // Stack(
              //   children: <Widget>[
              //     Positioned(
              //       child: Image.asset(
              //         imageDoctorDetails,
              //         width: 100,
              //         height: 428,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
