import 'package:patient/general_exports.dart';

class PassTypeAndAge extends GetxController {
  String? selected;

  TextEditingController TextfieldAge = TextEditingController();
  TextEditingController TextfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();

  bool viewVaildType = false;

  List<Map<String, String>> type = [
    {'gender': 'female'.tr, 'icon': iconFemale},
    {'gender': 'male'.tr, 'icon': iconMale},
  ];

  changeType(type) {
    selected = type;
    viewVaildType = false;
    update();
  }

  bool checkVaildType() {
    if (selected == null) {
      viewVaildType = true;
      update();
      return false;
    } else {
      viewVaildType = false;
      update();
      return true;
    }
  }
}
