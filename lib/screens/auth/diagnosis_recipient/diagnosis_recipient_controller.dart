import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? isMyChildrenSelected = 'aboutMe';

  TextEditingController TextfieldChronicDiseases = TextEditingController();
  TextEditingController TextfieldSurgicalOperations = TextEditingController();
  TextEditingController TextfieldContinuousMedications =
      TextEditingController();
  TextEditingController TextfieldAllergies = TextEditingController();

  bool isVaildChronicDiseases = false;
  bool isVaildSurgicalOperations = false;
  bool isVaildContinuousMedications = false;
  bool isVaildAllergies = false;

  List<Map<String, String>> typeDiagnosis = [
    {
      about: 'about_children'.tr,
      icon: iconAboutChildren,
      code: 'aboutChildren',
    },
    {about: 'about_me'.tr, icon: iconAboutMy, code: 'aboutMe'},
  ];

  changeTypeDiagnosis(String typeCode) {
    isMyChildrenSelected = typeCode;
    update();
  }

  bool dedical_history() {
    bool isValid = true;

    if (TextfieldChronicDiseases.text.isEmpty) {
      isVaildChronicDiseases = true;
      isValid = false;
    } else {
      isVaildChronicDiseases = false;
    }

    if (TextfieldSurgicalOperations.text.isEmpty) {
      isVaildSurgicalOperations = true;
      isValid = false;
    } else {
      isVaildSurgicalOperations = false;
    }

    if (TextfieldContinuousMedications.text.isEmpty) {
      isVaildContinuousMedications = true;
      isValid = false;
    } else {
      isVaildContinuousMedications = false;
    }

    if (TextfieldAllergies.text.isEmpty) {
      isVaildAllergies = true;
      isValid = false;
    } else {
      isVaildAllergies = false;
    }

    update();
    return isValid;
  }

  void clearAllFields() {
    TextfieldChronicDiseases.clear();
    TextfieldSurgicalOperations.clear();
    TextfieldContinuousMedications.clear();
    TextfieldAllergies.clear();

    isVaildChronicDiseases = false;
    isVaildSurgicalOperations = false;
    isVaildContinuousMedications = false;
    isVaildAllergies = false;

    update(); // عشان تحدث الـ UI
  }
}
