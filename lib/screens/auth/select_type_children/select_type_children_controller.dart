import 'package:patient/general_exports.dart';

class TypeController extends GetxController {
  String? selectedTypChildren = 'children_male';
  TextEditingController TextfieldAgeChildren = TextEditingController();
  TextEditingController TextfieldNameChildren = TextEditingController();

  bool isAgeChildrenInvalid = false;
  bool isNameChildrenInvalid = false;
  bool viewVaildTypeChildren = false;

  List<Map<String, String>> TypeChildrenGender = [
    {
      gender: 'type_children_fmale'.tr,
      icon: iconFemale,
      code: 'children_female',
    },
    {gender: 'type_children_male'.tr, icon: iconMale, code: 'children_male'},
  ];

  void changeTypeChildrenGender(String typeCodeChildrenGender) {
    selectedTypChildren = typeCodeChildrenGender;
    viewVaildTypeChildren = false;
    update();
  }

  bool checkVaildTypeChildren() {
    bool isValid = true;
    if (TextfieldAgeChildren.text.isEmpty) {
      isAgeChildrenInvalid = true;
      isValid = false;
    } else {
      isAgeChildrenInvalid = false;
    }

    if (TextfieldNameChildren.text.isEmpty) {
      isNameChildrenInvalid = true;
      isValid = false;
    } else {
      isNameChildrenInvalid = false;
    }

    update();
    return isValid;
  }
}
