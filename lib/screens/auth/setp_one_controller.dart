import 'package:patient/general_exports.dart';

class PassTypeAndAge extends GetxController {
  String? selected;
  TextEditingController Textfield = TextEditingController();
  bool viewVaildType = false;

  List<Map<String, String>> type = [
    {'gender': 'female'.tr, 'icon': iconFemale},
    {'gender': 'male'.tr, 'icon': iconMale},
  ];

  changeType(type) {
    selected = type;
    update();
  }

  checkVaildType() {
    print('test');
    // if (selected == null) {
    //   print('true');
    //   // viewVaildType = true;
    //   // update();
    //   return;
    // } else {
    //   print('false');
    //   // viewVaildType = false;
    //   // update();
    // }
    update();
  }
}
