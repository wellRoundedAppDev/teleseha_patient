import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? selected;
  bool showError = false;

  List<Map<String, String>> typeDiagnosis = [
    {'about': 'about_children'.tr, 'icon': aboutChildren},
    {'about': 'about_my'.tr, 'icon': aboutMy},
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
