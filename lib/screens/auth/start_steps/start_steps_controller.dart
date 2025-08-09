import '../../../general_exports.dart';

class StartStepsController extends GetxController {
  int selectedSteps = 1;
  String? selected;
  TextEditingController TextfieldAge = TextEditingController();
  TextEditingController TextfieldName = TextEditingController();
  TextEditingController TextfieldNumber = TextEditingController();

  bool viewVaildType = false;
  bool viewVaildAge = false;

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
    bool isValid = true;

    if (TextfieldAge.text.isEmpty || int.tryParse(TextfieldAge.text) == null) {
      viewVaildAge = true;
      isValid = false;
    } else {
      viewVaildAge = false;
    }

    if (selected == null) {
      viewVaildType = true;
      isValid = false;
    } else {
      viewVaildType = false;
    }

    update();
    return isValid;
  }
}
