import '../../general_exports.dart';

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
              horizontal: DEVICE_WIDTH * 0.045,
              vertical:
                  controller.goToComponentStatusBar.value != 'Subspecialties'
                  ? DEVICE_HEIGHT * 0.028
                  : DEVICE_HEIGHT * 0.045,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              color: Color(AppColors.backgroundColorLine),
            ),
            width: DEVICE_WIDTH,
            child: Obx(() {
              return controller.goToComponentStatusBar.value == 'HomePage'
                  ? ContentHome()
                  : controller.goToComponentStatusBar.value == 'Symptoms'
                  ? const ContentSymptoms()
                  : controller.goToComponentStatusBar.value == 'Doctors'
                  ? const ContentDoctors()
                  : controller.goToComponentStatusBar.value == 'Reception'
                  ? const ContentReception()
                  : controller.goToComponentStatusBar.value == 'successReception'
                  ? const SuccessReception()
                  : controller.goToComponentStatusBar.value == 'KnowledgeOfSpecialty'
                  ? const KnowledgeOfSpecialty()
                  : controller.goToComponentStatusBar.value == 'Subspecialty'
                  ? const ContentSubSpecialties()
                  : const ContentProfileDoctor();
            }),
          ),
        );
      },
    );
  }
}
