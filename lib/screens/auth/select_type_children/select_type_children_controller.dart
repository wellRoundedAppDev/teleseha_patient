import 'package:patient/general_exports.dart';

class TypeController extends GetxController {
  String? selectedTypChildren = 'children_male';

  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  bool showdateControllerError = false;
  bool showNameError = false;
  bool viewVaildTypeChildren = false;

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = picked;
      final formattedDate =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
      dateController.text = formattedDate;
      update();
    } else {
      print('❌ Date picker dismissed');
    }
  }

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
    if (textFieldName.text.isEmpty) {
      showNameError = true;
      isValid = false;
    } else {
      showNameError = false;
    }

    if (dateController.text.isEmpty) {
      showdateControllerError = true;
      isValid = false;
    } else {
      showdateControllerError = false;
    }

    update();
    return isValid;
  }
}
