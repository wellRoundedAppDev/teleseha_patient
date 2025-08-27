import '../../general_exports.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage controller =
        Get.find<ChangeParamContentAndNextPage>();
    return Obx(() {
      return controller.goToComponentHeader.value == 'HomePage'
          ? const HomeStatusBar()
          : controller.goToComponentHeader.value == 'Symptoms'
          ? const SymptomsStatusBar()
          : controller.goToComponentHeader.value == 'Doctors'
          ? DoctorsStatusBar()
          : controller.goToComponentHeader.value == 'ProfileDoctor'
          ? const ProfileDoctorStatusBar()
          : const OtherStatusBar();
    });
  }
}
