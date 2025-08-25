import '../../../general_exports.dart';

class ContentSympotomsController extends GetxController {
  // here create max lenght in filter add symoitoims
  TextEditingController filter = TextEditingController();
  bool isSelectedSymptoms = false;

  // this request about symptoms
  final List items = <dynamic>[
    <String, Object>{'title': 'symptoms1'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms2'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms3'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms4'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms5'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms6'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms7'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms8'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms9'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms10'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms11'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms12'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms13'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms14'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms15'.tr, 'isSelected': false},
  ];

  void changeValueCheck(int index, bool value) {
    items[index]['isSelected'] = value;
    isSelectedSymptoms = items.any((item) => item['isSelected'] == true);
    update();
  }

  void changeParamNextPage() {
    if (isSelectedSymptoms) {
      final ChangeParamContentAndNextPage changeParam = Get.find();
      changeParam.goToComponentStatusBar.value = 'Reception';
      changeParam.update();
    }
    update();
  }
}
