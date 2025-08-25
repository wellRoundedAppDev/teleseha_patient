import '../../../general_exports.dart';

class ContentSubSpecialties extends StatelessWidget {
  ContentSubSpecialties({super.key});
  final BottomNavController bottomController = Get.put(BottomNavController());
  final DoctorsController doctors = Get.put(DoctorsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      builder: (HomePageContentController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: 'subSpecialist'.tr,
              fontSize: 20,
              color: const Color(AppColors.colorSpecialties),
            ),
          ],
        );
      },
    );
  }
}
