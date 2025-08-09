import 'package:patient/general_exports.dart';

class TypeController extends GetxController {
  int selectedSteps = 3;
  String? selectedTypChildren;
  TextEditingController TextfieldAgeChildren = TextEditingController();
  TextEditingController TextfieldNameChildren = TextEditingController();

  bool viewAgeChildrenInvalid = false;
  bool viewNameChildrenInvalid = false;
  bool viewVaildTypeChildren = false;

  List<Map<String, String>> TypeChildren = [
    {'gender': 'type_children_fmale'.tr, 'icon': iconFemale},
    {'gender': 'type_children_male'.tr, 'icon': iconMale},
  ];

  changeTypeChildren(type) {
    selectedTypChildren = type;
    viewVaildTypeChildren = false;
    update();
  }

  bool checkVaildTypeChildren() {
    bool isValid = true;
    if (TextfieldAgeChildren.text.isEmpty) {
      viewAgeChildrenInvalid = true;
      isValid = false;
    } else {
      viewAgeChildrenInvalid = false;
    }

    if (TextfieldNameChildren.text.isEmpty) {
      viewNameChildrenInvalid = true;
      isValid = false;
    } else {
      viewNameChildrenInvalid = false;
    }

    if (selectedTypChildren == null) {
      viewVaildTypeChildren = true;
      isValid = false;
    } else {
      viewVaildTypeChildren = false;
    }

    update();
    return isValid;
  }
}
