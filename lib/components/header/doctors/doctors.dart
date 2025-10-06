import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class DoctorsStatusBar extends StatelessWidget {
  DoctorsStatusBar({super.key});

  final BottomNavController bottomController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final HomePageContentController contentHomePage = Get.find();
    Get.put(DoctorsController(), permanent: true);

    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.035),
          child: Container(
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        final BottomNavController findBottomController =
                            Get.find();
                        findBottomController.selectedIndexBottomNav.value = 2;

                        final ChangeParamContentAndNextPage changeParam =
                            Get.find();
                        changeParam.goToComponentHeader.value = 'HomePage';

                        changeParam.update();
                        findBottomController.update();
                      },
                      child: SvgPicture.asset(
                        iconBack,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.02),
                      child: const LogoHome(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: CustomInput(
                        hint: 'search_about_doctor'.tr,
                        controller: controller.filterDoctors,
                        showValidMessage: controller.showDoctors,
                        widthContainer: DEVICE_WIDTH,
                        fontSize: 14,
                        colorLabel: AppColors.colorLineAndText,
                        keyboardType: TextInputType.text,
                        suffixIconPath: iconSearch,
                        onSuffixIconTap: () {
                          final DoctorsController doctor = Get.find();
                          doctor.doctorsRequest();
                        },
                        sizespace: 0.01,
                        paddingVertical: 0.037,
                      ),
                    ),
                    SizedBox(width: DEVICE_WIDTH * 0.018),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          contentHomePage.isDrawerOpen.value = true;
                          contentHomePage.update();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: DEVICE_WIDTH,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(AppColors.colorWhite),
                              width: 0.8,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 13),
                          padding: EdgeInsets.symmetric(
                            vertical: DEVICE_HEIGHT * 0.025,
                          ),
                          child: SvgPicture.asset(
                            iconFilter,
                            width: DEVICE_WIDTH * 0.018,
                            height: DEVICE_HEIGHT * 0.018,
                            fit: BoxFit.cover,
                          ),
                        ),
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
