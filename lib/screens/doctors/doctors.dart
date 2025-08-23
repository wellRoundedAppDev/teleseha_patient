import '../../general_exports.dart';

class Doctors extends StatelessWidget {
  const Doctors({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (DoctorsController controller) {
        return Scaffold(
          backgroundColor: const Color(AppColors.colorLineAndText),
          body: Column(
            children: <Widget>[
              // Text('${controller.passedIndex}'),
              StatusBar(goToComponentStatusBar: 'Doctors'),
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              ContentArea(goToComponentContentArea: 'Doctors'),
            ],
          ),
        );
      },
    );
  }
}
