import 'package:patient/general_exports.dart';

class DiagnsisRecipientController extends GetxController {
  String? isMyChildrenSelected = 'aboutMe';

  TextEditingController textfieldChronicDiseases = TextEditingController();
  TextEditingController textfieldSurgicalOperations = TextEditingController();
  TextEditingController textfieldContinuousMedications =
      TextEditingController();
  TextEditingController textfieldAllergies = TextEditingController();

  bool showChronicDiseases = false;
  bool showSurgicalOperations = false;
  bool showContinuousMedications = false;
  bool showAllergies = false;

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

    if (textfieldChronicDiseases.text.isEmpty) {
      showChronicDiseases = true;
      isValid = false;
    } else {
      showChronicDiseases = false;
    }

    if (textfieldSurgicalOperations.text.isEmpty) {
      showSurgicalOperations = true;
      isValid = false;
    } else {
      showSurgicalOperations = false;
    }

    if (textfieldContinuousMedications.text.isEmpty) {
      showContinuousMedications = true;
      isValid = false;
    } else {
      showContinuousMedications = false;
    }

    if (textfieldAllergies.text.isEmpty) {
      showAllergies = true;
      isValid = false;
    } else {
      showAllergies = false;
    }

    update();
    return isValid;
  }

  void clearAllFields() {
    textfieldChronicDiseases.clear();
    textfieldSurgicalOperations.clear();
    textfieldContinuousMedications.clear();
    textfieldAllergies.clear();

    showChronicDiseases = false;
    showSurgicalOperations = false;
    showContinuousMedications = false;
    showAllergies = false;

    update(); // عشان تحدث الـ UI
  }
}
