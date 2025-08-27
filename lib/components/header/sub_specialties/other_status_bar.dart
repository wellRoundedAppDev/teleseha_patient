import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class OtherStatusBar extends StatelessWidget {
  const OtherStatusBar({super.key});

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
                  change.goToComponentHeader.value == 'drSchedule'
                      ? change.goToComponentHeader.value = 'Doctors'
                      : change.goToComponentHeader.value == 'Reception' ||
                            change.goToComponentHeader.value ==
                                'successReception'
                      ? change.goToComponentHeader.value = 'Symptoms'
                      : change.goToComponentHeader.value = 'HomePage';
                  change.update();
                },
                child: SvgPicture.asset(
                  iconArrow,
                  width: DEVICE_WIDTH * 0.034,
                  height: DEVICE_HEIGHT * 0.034,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
