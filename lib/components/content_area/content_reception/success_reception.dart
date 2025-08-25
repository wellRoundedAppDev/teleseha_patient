import 'package:flutter_svg/flutter_svg.dart';

// import 'package:url_launcher/url_launcher.dart';

import '../../../general_exports.dart';
// import 'paymob_manager.dart';

class SuccessReception extends StatelessWidget {
  const SuccessReception({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();

    return GetBuilder<ReceptionController>(
      init: ReceptionController(),
      builder: (ReceptionController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: DEVICE_HEIGHT * 0.015),
            CustomText(
              text: 'reception'.tr,
              fontSize: 20,
              type: CustomTextType.title,
              color: const Color(AppColors.colorLineAndText),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.11),
            Column(
              children: <Widget>[
                SvgPicture.asset(
                  successMark,
                  width: DEVICE_WIDTH * 0.135,
                  height: DEVICE_HEIGHT * 0.135,
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.05),
                CustomText(
                  text: 'specialization_selected'.tr,
                  fontSize: 16,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
                SizedBox(height: DEVICE_HEIGHT * 0.08),
                Btn(
                  // onPressed: () async => _pay,
                  onPressed: () {
                    change.goToComponentStatusBar.value =
                        'KnowledgeOfSpecialty';
                    change.update();
                  },
                  text: 'buy'.tr,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Future<void> _pay() async {
  //   PayMobManager().getPaymentKey(10, 'EGP').then((String paymentKey) {
  //     launchUrl(
  //       Uri.parse(
  //         "https://accept.paymob.com/api/acceptance/iframe/5555/?payment_token${paymentKey}",
  //       ),
  //     );
  //   });
  // }
}
