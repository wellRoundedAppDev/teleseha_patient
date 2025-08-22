import 'package:flutter_svg/flutter_svg.dart';

import '../../general_exports.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (BottomNavController controller) {
        return Container(
          margin: EdgeInsets.only(
            bottom: DEVICE_HEIGHT * 0.061,
            left: DEVICE_WIDTH * 0.04,
            right: DEVICE_WIDTH * 0.04,
          ),
          decoration: BoxDecoration(
            color: const Color(AppColors.colorWhiteSelectedType),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 20),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(controller.labels.length, (int index) {
              final bool isSelected = controller.selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  controller.changeIndex(index);
                },
                child: SizedBox(
                  width: DEVICE_WIDTH * 0.18,
                  height: DEVICE_HEIGHT * 0.097,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: <Widget>[
                      if (isSelected)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: -8,
                          right: -8,
                          child: Material(
                            color: Colors.blue.withOpacity(0.1),
                            elevation: 10,
                            shadowColor: const Color(0x1A4F5565),
                            shape: const CircleBorder(),
                            child: const SizedBox.expand(),
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            controller.icons[index],
                            width: DEVICE_WIDTH * 0.1,
                            height: DEVICE_HEIGHT * 0.025,
                            fit: BoxFit.cover,
                            color: isSelected
                                ? const Color(AppColors.colorLineAndText)
                                : const Color(AppColors.colorSelectDropDown),
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.003),
                          CustomText(
                            text: controller.labels[index],
                            fontSize: 8,
                            type: CustomTextType.title,
                            color: isSelected
                                ? const Color(AppColors.colorLineAndText)
                                : const Color(AppColors.colorSelectDropDown),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
