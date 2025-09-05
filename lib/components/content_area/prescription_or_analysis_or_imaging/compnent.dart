import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class PrescriptionOrAnalysisOrImaging extends StatelessWidget {
  const PrescriptionOrAnalysisOrImaging({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: DEVICE_WIDTH * 0.02),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: 'prescription'.tr,
                    fontSize: 18,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorTextBlue),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  SvgPicture.asset(
                    iconCard,
                    width: DEVICE_WIDTH * 0.04,
                    height: DEVICE_HEIGHT * 0.03,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.01),
              const CustomText(
                text: 'RX-20250824-00021',
                fontSize: 10,
                type: CustomTextType.title,
                color: Color.fromRGBO(0, 123, 189, 0.74),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
