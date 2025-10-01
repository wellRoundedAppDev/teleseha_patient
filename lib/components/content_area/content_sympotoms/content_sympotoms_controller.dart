import '../../../general_exports.dart';

class ContentSymptomsController extends GetxController {
  // here create max length in filter add symptoms
  TextEditingController filter = TextEditingController();
  TextEditingController writingPresentation = TextEditingController();
  bool isSelectedSymptoms = false;

  // this request about symptoms
  // ignore: always_specify_types
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
    // ignore: always_specify_types
    isSelectedSymptoms = items.any((item) => item['isSelected'] == true);
    update();
  }

  void changeParamNextPage() {
    if (isSelectedSymptoms) {
      // comping from success is complete going to doctor and success
      final ChangeParamContentAndNextPage changeParam = Get.find();
      final HomePageContentController changePage = Get.find();
      if (changeParam.knowNextPage.value ==
          'Comping from home going to reception') {
        // changePage.checkReservations = false;
        changeParam.goToComponentHeader.value = 'Reception';
        changeParam.update();
      } else {
        // changePage.checkReservations = true;
        changeParam.goToComponentHeader.value = 'successSendToDoctor';
        changeParam.update();
      }
    }
    update();
  }
}
