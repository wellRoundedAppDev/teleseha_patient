import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? selected;
  bool showError = false;

  List<Map<String, String>> typeDiagnosis = [
    {'about': 'aboutChildren'.tr, 'icon': aboutChildren},
    {'about': 'aboutMy'.tr, 'icon': aboutMy},
  ];

  changeType(String type) {
    selected = type;
    showError = false;
    update();
  }

  bool checkVaild() {
    bool isValid = selected != null;
    if (!isValid) {
      showError = true;
      update();
    }
    return isValid;
  }
}
