import '../../../general_exports.dart';

class TypeController extends GetxController {
  String? selectedTypChildren = 'children_male';

  TextEditingController dateController = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  bool showdateControllerError = false;
  bool showNameError = false;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = picked;
      final String formattedDate =
          '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
      dateController.text = formattedDate;
      update();
    } else {
      consoleLog('❌ Date picker dismissed');
    }
  }

  List<Map<String, String>> typeChildrenGender = <Map<String, String>>[
    <String, String>{
      gender: 'type_children_female'.tr,
      icon: iconFemale,
      code: 'children_female',
    },
    <String, String>{
      gender: 'type_children_male'.tr,
      icon: iconMale,
      code: 'children_male',
    },
  ];

  void changeTypeChildrenGender(String typeCodeChildrenGender) {
    selectedTypChildren = typeCodeChildrenGender;
    update();
  }

  bool checkValidTypeChildren() {
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
