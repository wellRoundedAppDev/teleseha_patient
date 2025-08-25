import '../../general_exports.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeParamContentAndNextPage>();
    return Obx(() {
      return controller.goToComponentStatusBar.value == 'HomePage'
          ? const HomeStatusBar()
          : controller.goToComponentStatusBar.value == 'Symptoms'
          ? const SymptomsStatusBar()
          : controller.goToComponentStatusBar.value == 'Doctors'
          ? DoctorsStatusBar()
          : const OntherStatusBar();
    });
  }
}
