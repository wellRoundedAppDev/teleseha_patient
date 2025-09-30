import 'package:flutter_svg/svg.dart';

import '../../components/containerSettings.dart';
import '../../general_exports.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (BottomNavController controller) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.027),
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    controller.selectedIndexBottomNav.value = 2;

                    final ChangeParamContentAndNextPage changeParam =
                        Get.find();
                    changeParam.goToComponentHeader.value = 'HomePage';

                    changeParam.update();
                    controller.update();
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    width: 24,
                    height: 24,
                    // ignore: deprecated_member_use
                    color: Colors.black,
                  ),
                ),
                // SizedBox(height: 7 ),
                Container(
                  width: DEVICE_WIDTH,
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(AppColors.colorEndChat),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: Image.asset(
                                imageUser,
                                width: 100,
                                height: 85,
                              ),
                            ),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                          CustomText(
                            text: 'name_field'.tr,
                            fontSize: 12,
                            type: CustomTextType.title,
                            color: const Color(AppColors.colorLineAndText),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                          StyleBtnHeader(
                            textBtn: 'update_profile'.tr,
                            size: 10,
                            width: 0.37,
                            height: 0.055,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.06),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.34,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ContainerSettings(
                                title: 'persion_data'.tr,
                                icon: iconDataUser,
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.035),
                              ContainerSettings(
                                title: 'medical_history1'.tr,
                                isActive: false,
                                isActiveSwitch: true,
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.035),
                              ContainerSettings(
                                title: 'settings'.tr,
                                icon: iconSettings1,
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.035),
                              ContainerSettings(
                                title: 'technical_support'.tr,
                                icon: iconTechnicalSupport,
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.035),
                              ContainerSettings(
                                title: 'history_pay'.tr,
                                icon: iconHistoryBuy,
                              ),
                              SizedBox(height: DEVICE_HEIGHT * 0.035),
                              ContainerSettings(
                                title: 'log_out'.tr,
                                icon: iconLogOut,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
