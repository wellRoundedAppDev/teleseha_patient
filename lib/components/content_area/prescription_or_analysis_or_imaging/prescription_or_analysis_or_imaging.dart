import '../../../general_exports.dart';

class PrescriptionOrAnalysisOrImaging extends StatelessWidget {
  const PrescriptionOrAnalysisOrImaging({
    required this.ChangeContent,
    super.key,
  });

  final RxString ChangeContent;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPresciption>(
      init: ListPresciption(),
      builder: (ListPresciption controller) {
        return RepaintBoundary(
          key: controller.previewContainer,
          child: Container(
            margin: EdgeInsets.only(top: DEVICE_WIDTH * 0.04),
            height: 786,
            child: Obx(() {
              switch (ChangeContent.value) {
                case 'Prescription':
                  return PrescriptionWidget(controller, ChangeContent);
                case 'The radiology':
                  return RadiologyWidget(controller, ChangeContent);
                case 'analyses':
                  return Analyses(controller, ChangeContent);
                default:
                  return const Center(child: Text('No content selected'));
              }
            }),
          ),
        );
      },
    );
  }
}
