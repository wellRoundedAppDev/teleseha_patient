// views/pattern_lock_view.dart
import 'package:flutter_svg/svg.dart';

import '../../../../general_exports.dart';

class Profiles extends StatelessWidget {
  const Profiles({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                backgroundColor: const Color(AppColors.colorBackgroundScreen),
                automaticallyImplyLeading: false,
                title: Directionality(
                  textDirection: TextDirection.rtl,
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
                          // ignore: deprecated_member_use
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
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.035,
                  horizontal: DEVICE_HEIGHT * 0.01,
                ),
                child: Column(
                  children: <Widget>[
                    // const Logo(),
                    SizedBox(height: DEVICE_HEIGHT * 0.0425),
                    CustomText(
                      text: 'create_account_me'.tr,
                      fontSize: 24,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorTextBlue),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.075),
                    Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.profiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(24, 0, 25, 24),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 22,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                DEVICE_HEIGHT * 0.025,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: DEVICE_WIDTH * 0.22,
                                  height: DEVICE_HEIGHT * 0.035,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        AppColors.colorLineAndText,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: DEVICE_HEIGHT * 0.01,
                                        vertical: DEVICE_HEIGHT * 0.001,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.toNamed(routeScreen);
                                    },
                                    child: CustomText(
                                      text: 'login'.tr,
                                      fontSize: 9,
                                      color: const Color(
                                        AppColors.colorBackgroundScreen,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.02),
                                CustomText(
                                  text:
                                      controller.profiles[index]['name'] ?? '',
                                  fontSize: 15,
                                  type: CustomTextType.title,
                                  color: const Color(
                                    AppColors.colorSelectDropDown,
                                  ),
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
          ),
        );
      },
    );
  }
}
