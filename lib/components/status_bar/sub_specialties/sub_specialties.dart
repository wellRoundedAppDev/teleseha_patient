import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class SubSpecialtiesStatusBar extends StatelessWidget {
  const SubSpecialtiesStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<ContentSympotomsController>(
      init: ContentSympotomsController(),
      builder: (ContentSympotomsController controller) {
        return Container(
          width: DEVICE_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.06),
          margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(change.knowNextPage.value),
              GestureDetector(
                onTap: () {
                  change.goToComponentStatusBar.value = 'HomePage';
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
