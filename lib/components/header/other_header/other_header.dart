import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class OtherHeader extends StatelessWidget {
  const OtherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<ContentSymptomsController>(
      init: ContentSymptomsController(),
      builder: (ContentSymptomsController controller) {
        return Container(
          width: DEVICE_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.07),
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  change.goToComponentHeader.value == 'waitingForYourTurn'
                      ? change.goToComponentHeader.value = 'RecentBookings'
                      : change.goToComponentHeader.value == 'drSchedule'
                      ? change.goToComponentHeader.value = 'Doctors'
                      : change.goToComponentHeader.value == 'DoctorEvaluation'
                      ? change.goToComponentHeader.value = 'waitingForYourTurn'
                      : change.goToComponentHeader.value ==
                            'ContentPrescription'
                      ? change.goToComponentHeader.value = 'DoctorEvaluation'
                      : change.goToComponentHeader.value == 'Reception' ||
                            change.goToComponentHeader.value ==
                                'successReception'
                      ? change.goToComponentHeader.value = 'Symptoms'
                      : change.goToComponentHeader.value = 'HomePage';
                  change.update();
                },
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      iconBack,
                      width: DEVICE_WIDTH * 0.034,
                      height: DEVICE_HEIGHT * 0.034,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: DEVICE_WIDTH * 0.22),
                    const LogoHome(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
