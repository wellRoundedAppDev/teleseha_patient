import 'package:flutter_svg/flutter_svg.dart';

import '../../general_exports.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.065),
          child: Container(
            margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                            iconUser,
                            width: DEVICE_WIDTH * 0.034,
                            height: DEVICE_HEIGHT * 0.034,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.01),
                          Text(
                            "${'say_welcome'.tr} ${controller.testUserData}!",
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(AppColors.colorWhiteSelectedType),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        SvgPicture.asset(
                          iconNotification,
                          height: DEVICE_HEIGHT * 0.03,
                        ),
                        Positioned(
                          top: DEVICE_WIDTH * -0.025,
                          right: DEVICE_HEIGHT * -0.002,
                          child: Container(
                            width: DEVICE_WIDTH * 0.03,
                            height: DEVICE_HEIGHT * 0.03,
                            decoration: BoxDecoration(
                              color: const Color(
                                AppColors.colorPointerNotification,
                              ),
                              shape: BoxShape.circle,
                              border: BoxBorder.all(
                                color: const Color(
                                  AppColors.colorPointerborder,
                                ),
                                width: DEVICE_WIDTH * 0.004,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Text(
                          "${'say_welcome'.tr}!",
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(AppColors.colorWhiteSelectedType),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${'say_welcome'.tr}!",
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(AppColors.colorWhiteSelectedType),
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
