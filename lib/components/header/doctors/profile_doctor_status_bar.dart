import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ProfileDoctorStatusBar extends StatelessWidget {
  const ProfileDoctorStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
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
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      change.goToComponentHeader.value = 'Doctors';
                      change.update();
                    },
                    child: SvgPicture.asset(
                      iconBack,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.22),
                  const LogoHome(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
