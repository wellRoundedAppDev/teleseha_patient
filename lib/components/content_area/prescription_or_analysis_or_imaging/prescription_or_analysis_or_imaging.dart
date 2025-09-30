import '../../../general_exports.dart';

class PrescriptionOrAnalysisOrImaging extends StatelessWidget {
  const PrescriptionOrAnalysisOrImaging({
    // ignore: non_constant_identifier_names
    required this.ChangeContent,
    super.key,
  });

  // ignore: non_constant_identifier_names
  final RxString ChangeContent;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPresciption>(
      builder: (ListPresciption controller) {
        return Container(
          margin: EdgeInsets.only(top: DEVICE_WIDTH * 0.04),
          height: 786,
          child: Obx(() {
            switch (ChangeContent.value) {
              case 'prescription':
                return PrescriptionWidget(controller, ChangeContent);
              case 'The radiology':
                return RadiologyWidget(controller, ChangeContent);
              case 'analyses':
                return Analyses(controller, ChangeContent);
              default:
                return const Center(child: Text('No content selected'));
            }
          }),
        );
      },
    );
  }
}
