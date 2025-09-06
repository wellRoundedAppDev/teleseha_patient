import '../../../general_exports.dart';
import 'prescription_or_analysis_or_imaging.dart';

class ContentPrescription extends StatelessWidget {
  const ContentPrescription({super.key});

  @override
  Widget build(BuildContext context) {
    return PrescriptionOrAnalysisOrImaging(ChangeContent: 'Prescription'.obs);
  }
}
