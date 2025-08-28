import 'package:flutter_svg/flutter_svg.dart';

import '../../general_exports.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (BottomNavController controller) {
        return Container(
          height: DEVICE_HEIGHT * 0.087,
          margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.05),
          decoration: BoxDecoration(
            color: const Color(AppColors.colorWhiteSelectedType),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 20),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: always_specify_types
            children: List.generate(controller.labels.length, (int index) {
              final bool isSelected = controller.selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  controller.changeIndex(index);
                },
                child: Container(
                  width: isSelected ? controller.widthSelected : 70,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color(0xFFB8D9F1),
                              Color.fromARGB(111, 184, 217, 241),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(
                      controller.selectedIndex == 0 ||
                              controller.selectedIndex == 4
                          ? 20
                          : 100,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        controller.icons[index],
                        width: DEVICE_WIDTH * 0.1,
                        height: DEVICE_HEIGHT * 0.025,
                        fit: BoxFit.cover,
                        // ignore: deprecated_member_use
                        color: isSelected
                            ? const Color(AppColors.colorLineAndText)
                            : const Color(AppColors.colorSelectDropDown),
                      ),
                      SizedBox(height: DEVICE_HEIGHT * 0.003),
                      CustomText(
                        text: controller.labels[index],
                        fontSize: 8.5,
                        type: CustomTextType.title,
                        color: isSelected
                            ? const Color(AppColors.colorLineAndText)
                            : const Color(AppColors.colorSelectDropDown),
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
