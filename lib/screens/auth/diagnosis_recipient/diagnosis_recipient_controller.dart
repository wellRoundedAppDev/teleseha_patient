import '../../../general_exports.dart';

class DiagnosisRecipientController extends GetxController {
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

  List<Map<String, String>> typeDiagnosis = <Map<String, String>>[
    <String, String>{about: 'other'.tr, icon: iconOther, code: 'other'},
    <String, String>{about: 'about_me'.tr, icon: iconAboutMy, code: 'aboutMe'},
  ];

  void changeTypeDiagnosis(String typeCode) {
    isMyChildrenSelected = typeCode;
    update();
  }

  void howDiagnosis() {
    consoleLog('Current diagnosis type: $isMyChildrenSelected');
    if (isMyChildrenSelected == 'aboutMe') {
      Get.toNamed(routeFormDiagnosis);
    } else {
      Get.toNamed(routeSelectTypeChildren);
    }
  }

  bool dedicalHistory() {
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

    update();
  }
}
