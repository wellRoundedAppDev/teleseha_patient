import '../../../general_exports.dart';

class MedicalHistoryController extends GetxController {
  int currentStep = 1;
  int get numberOfStep => questions.length;
  String? accessToken;
  String? showIsError;
  bool isLoading = false;
  bool isSendingAnswer = false;

  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    medicalProfileSection();
  }

  // ignore: always_specify_types
  List questions = [];

  Future<void> medicalProfileSection() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: pathMedicalProfileSection,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        questions = response ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        showIsError = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  Future<void> sendAnswer(int patientId, int sectionId, String answer) async {
    isSendingAnswer = true;
    update();

    accessToken = await localStorage.readFromStorage(storageAccessToken);

    await ApiRequest(
      path: '$pathMedicalProfileSection/$patientId/$sectionId',
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: <String, String>{'answer': answer},
    ).request(
      onSuccess: (data, response) {
        consoleLog('Answer sent successfully for section $sectionId');
      },
      onError: (error) {
        consoleLog('Failed to send answer for section $sectionId');
        return null;
      },
    );
    isSendingAnswer = false;
    update();
  }

  void nextStep() {
    if (currentStep < questions.length) {
      currentStep++;
      update();
    }
  }

  bool get hasSelectedAnswer {
    if (questions.isEmpty) return false;
    final currentQuestion = questions[currentStep - 1];
    return currentQuestion['isSelected'] != null;
  }
}
