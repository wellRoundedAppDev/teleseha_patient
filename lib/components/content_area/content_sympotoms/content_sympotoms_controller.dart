import '../../../general_exports.dart';

class ContentSympotomsController extends GetxController {
  TextEditingController filter = TextEditingController();

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
    <String, Object>{'title': 'symptoms13'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms14'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms15'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms13'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms14'.tr, 'isSelected': false},
    <String, Object>{'title': 'symptoms15'.tr, 'isSelected': false},
  ];

  final double spacing = 8.0;

  void changeValueCheck(int index, bool value) {
    items[index]['isSelected'] = value;
    update();
  }
}
