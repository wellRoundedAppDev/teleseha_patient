import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class SymptomsStatusBar extends StatelessWidget {
  const SymptomsStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return GetBuilder<ContentSymptomsController>(
      init: ContentSymptomsController(),
      builder: (ContentSymptomsController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.05),
          child: Container(
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // Text(change.knowNextPage.value),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        change.goToComponentHeader.value = 'HomePage';
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
                const SizedBox(height: 30),
                Stack(
                  children: <Widget>[
                    TextField(
                      controller: controller.writingPresentation,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'WritingUnavailableOffer'.tr,
                        hintStyle: const TextStyle(
                          color: Color(AppColors.colorHintText),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.06,
                          vertical: DEVICE_HEIGHT * 0.02,
                        ),
                        filled: true,
                        fillColor: const Color(
                          AppColors.colorWhiteSelectedType,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    // create post request when add symptoms
                    Positioned(
                      left: DEVICE_WIDTH * 0.05,
                      top: 12,
                      child: StyleBtnHeader(
                        size: 10,
                        textBtn: 'create'.tr,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
