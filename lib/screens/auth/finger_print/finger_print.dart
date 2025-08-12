import '../../../../general_exports.dart';

class FingerPrint extends StatelessWidget {
  const FingerPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'title_foot_print'.tr,
            style: TextStyle(
              color: Color(AppColors.colorTextBlue),
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
              fontSize: 20,
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.04),
          Text(
            'text_foot_print'.tr,
            style: TextStyle(
              color: Color(AppColors.colorselectDropDown),
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
              fontSize: 14,
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.04),
          SvgPicture.asset(
            footPrint,
            width: DEVICE_WIDTH * 0.15,
            height: DEVICE_HEIGHT * 0.15,
            fit: BoxFit.cover,
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.04),
          Text(
            'put_your_finger'.tr,
            style: TextStyle(
              color: Color(AppColors.colorLineAndText),
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
              fontSize: 21,
            ),
          ),
        ],
      ),
    );
  }
}

// Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: StepsBtn(
//                                           onPressed: () {},
//                                           text: 'again'.tr,
//                                           color: Color(
//                                             AppColors.colorTextBlueBlur,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: DEVICE_WIDTH * 0.04),
//                                       Expanded(
//                                         child: StepsBtn(
//                                           onPressed: () {
//                                             controller.checkBiometrics();
//                                           },
//                                           text: 'save'.tr,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )
