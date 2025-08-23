import '../../general_exports.dart';

class StatusBar extends StatelessWidget {
  StatusBar({super.key, this.goToComponentStatusBar});

  String? goToComponentStatusBar;

  @override
  Widget build(BuildContext context) {
    return goToComponentStatusBar == 'HomePage'
        ? const HomeStatusBar()
        : goToComponentStatusBar == 'Symptoms'
        ? const SymptomsStatusBar()
        : DoctorsStatusBar();
  }
}
