import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? isMyChildrenSelected = 'aboutMe';

  List<Map<String, String>> typeDiagnosis = [
    {about: 'about_children'.tr, icon: iconAboutChildren, code: 'aboutChildren'},
    {about: 'about_me'.tr, icon: iconAboutMy, code: 'aboutMe'},
  ];

  changeTypeDiagnosis(String typeCode) {
    isMyChildrenSelected = typeCode;
    update();
  }
}
