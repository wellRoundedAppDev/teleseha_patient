import '../../general_exports.dart';
// import 'paymob_manager.dart';
// import 'package:url_launcher/url_launcher.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeParamContentAndNextPage>(
      init: ChangeParamContentAndNextPage(),
      builder: (ChangeParamContentAndNextPage controller) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:
                  controller.goToComponentHeader.value == 'ProfileDoctor' ||
                      controller.goToComponentHeader.value == 'drSchedule'
                  ? DEVICE_WIDTH * 0
                  : DEVICE_WIDTH * 0.045,
              vertical: controller.goToComponentHeader.value != 'Subspecialty'
                  ? DEVICE_HEIGHT * 0.028
                  : DEVICE_HEIGHT * 0.045,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
              ),
              color: controller.goToComponentHeader.value != 'Symptoms'
                  ? const Color(AppColors.colorBackgroundScreen)
                  : const Color(AppColors.backgroundColorLine),
            ),
            width: DEVICE_WIDTH,
            child: Obx(() {
              return controller.goToComponentHeader.value == 'HomePage'
                  ? ContentHome()
                  : controller.goToComponentHeader.value == 'Symptoms'
                  ? const ContentSymptoms()
                  : controller.goToComponentHeader.value == 'Doctors'
                  ? const ContentDoctors()
                  : controller.goToComponentHeader.value == 'Reception'
                  ? const ContentReception()
                  : controller.goToComponentHeader.value == 'successReception'
                  ? SuccessReception(
                      textBtn: 'buy'.tr,
                      specializationSelected: 'specialization_selected'.tr,
                      onPressed: () {
                        controller.goToComponentHeader.value =
                            'KnowledgeOfSpecialty';
                        controller.update();
                      },
                    )
                  : controller.goToComponentHeader.value ==
                        'KnowledgeOfSpecialty'
                  ? const KnowledgeOfSpecialty()
                  : controller.goToComponentHeader.value == 'Subspecialty'
                  ? const ContentSubSpecialties()
                  : controller.goToComponentHeader.value == 'drSchedule'
                  ? const DrSchedule()
                  : const ContentProfileDoctor();
            }),
          ),
        );
      },
    );
  }
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