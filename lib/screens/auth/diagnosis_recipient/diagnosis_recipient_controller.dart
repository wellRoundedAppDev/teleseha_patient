import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? selected;
  List<Map<String, String>> typeDiagnosis = [
    {'about': 'aboutChildren'.tr, 'icon': aboutChildren},
    {'about': 'aboutMy'.tr, 'icon': aboutMy},
  ];

  changeType(String type) {
    selected = type;
    update();
  }
}
