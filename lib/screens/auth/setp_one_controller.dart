import 'package:patient/general_exports.dart';

class PassTypeAndAge extends GetxController {
  String? selected;
  TextEditingController Textfield = TextEditingController();

  List<Map<String, String>> type = [
    {'gender': 'female'.tr, 'icon': iconFemale},
    {'gender': 'male'.tr, 'icon': iconMale},
  ];

  changeType(type) {
    selected = type;
    update();
  }
}
