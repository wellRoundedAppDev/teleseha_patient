import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../general_exports.dart';

class ContainerSettings extends StatelessWidget {
  const ContainerSettings({
    required this.title,
    this.icon,
    super.key,
    this.isActive = true,
    this.isActiveSwitch = false,
  });
  final String title;
  final String? icon;
  final bool isActive;
  final bool isActiveSwitch;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Mypagecontroller>(
      init: Mypagecontroller(),
      builder: (Mypagecontroller controller) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: DEVICE_WIDTH * 0.04,
            horizontal: DEVICE_HEIGHT * 0.03,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(AppColors.colorWhiteSelectedType),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFFD8DADC).withAlpha(102),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: isActive
                    ? SvgPicture.asset(
                        iconArrowSmaill,
                        width: DEVICE_WIDTH * 0.02,
                        height: DEVICE_HEIGHT * 0.02,
                      )
                    : const SizedBox(),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: CustomText(
                  text: title,
                  fontSize: 14,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorSelectDropDown),
                ),
              ),
              if (icon != null) SvgPicture.asset(icon!) else const SizedBox(),
              if (isActiveSwitch)
                FlutterSwitch(
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 15.0,
                  value: controller.isToggled,
                  onToggle: controller.toggleSwitch,
                  activeColor: const Color(AppColors.colorCheck),
                  inactiveSwitchBorder: Border.all(
                    color: const Color(AppColors.colorBordercheck),
                  ),
                  inactiveColor: const Color(AppColors.colorWhiteSelectedType),
                  toggleBorder: Border.all(
                    color: const Color(AppColors.colorBordercheck),
                    width: 2.0,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
