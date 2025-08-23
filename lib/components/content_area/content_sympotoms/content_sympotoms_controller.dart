import '../../../general_exports.dart';

class ContentSympotomsController extends GetxController {
  // here create max lenght in filter add symoitoims
  TextEditingController filter = TextEditingController();
  final double spacing = 7.0;

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

  double calculateItemWidth(int index, double maxWidth) {
    double itemWidth;
    if (index == 0) {
      itemWidth = maxWidth;
    } else {
      final int row = (index / 2).floor();
      if (row.isOdd) {
        itemWidth = (maxWidth * 0.38) - (spacing / 2);
      } else {
        itemWidth = (maxWidth * 0.62) - (spacing / 2);
      }
    }
    return itemWidth;
  }

  void changeValueCheck(int index, bool value) {
    items[index]['isSelected'] = value;
    update();
  }
}
