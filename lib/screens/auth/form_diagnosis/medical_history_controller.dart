import '../../../general_exports.dart';

class MedicalHistoryController extends GetxController {
  String selectedOption = '';
  void selectOption(String? value) {
    selectedOption = value ?? '';
    update();
  }
}
