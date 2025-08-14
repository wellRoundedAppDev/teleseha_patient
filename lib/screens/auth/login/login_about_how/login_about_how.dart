// views/pattern_lock_view.dart
import 'package:flutter_svg/svg.dart';

import '../../../../general_exports.dart';

class LoginAboutHow extends StatelessWidget {
  const LoginAboutHow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatternLockController>(
      init: PatternLockController(),
      builder: (PatternLockController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppBar(
                  leading: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        iconBack,
                        width: DEVICE_WIDTH * 0.04,
                        height: DEVICE_HEIGHT * 0.02,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  title: SizedBox(
                    width: DEVICE_WIDTH * 0.425,
                    height: DEVICE_HEIGHT * 0.0108,
                    child: LinearProgressIndicator(
                      value: 1,
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: const Color(
                        AppColors.backgroundColorLine,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(
                          AppColors.colorLineAndText,
                        ).withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Logo(),
                  SizedBox(height: DEVICE_HEIGHT * 0.05),
                  CustomText(
                    text: 'create_account_me'.tr,
                    fontSize: 24,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.08),
                  Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.usersIntegrate.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                            DEVICE_HEIGHT * 0.04,
                            0,
                            DEVICE_HEIGHT * 0.04,
                            DEVICE_HEIGHT * 0.023,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: DEVICE_HEIGHT * 0.025,
                            vertical: DEVICE_WIDTH * 0.035,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              DEVICE_HEIGHT * 0.025,
                            ),
                            color: const Color(AppColors.colorLineAndText),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: DEVICE_WIDTH * 0.23,
                                height: DEVICE_HEIGHT * 0.03,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('login'.tr),
                                ),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.02),
                              Row(
                                children: <Widget>[
                                  CustomText(
                                    text: 'name_user'.tr,
                                    fontSize: 15,
                                    type: CustomTextType.title,
                                    color: const Color(
                                      AppColors.colorWhiteSelectedType,
                                    ),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.03),
                                  SvgPicture.asset(
                                    iconUser,
                                    width: DEVICE_WIDTH * 0.035,
                                    height: DEVICE_HEIGHT * 0.035,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
