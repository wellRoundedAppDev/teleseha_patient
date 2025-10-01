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
      header: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
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

  Future<void> patientMedicalProfileSectionPost() async {
    await ApiRequest(
      path: pathPatientMedicalProfileSection,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: <String, Object>{
        patientId: 124,
        section: <String, Object>{
          id: 2,
          title: 'string',
          subSection: <Map<String, Object>>[
            <String, Object>{
              id: 1,
              title: 'string',
              items: <Map<String, Object>>[
                <String, Object>{id: 1, item: 'string'},
              ],
            },
          ],
        },
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        // Get.toNamed(details);
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final MyAppController appController = Get.find();
          appController.futureRefreshLogin();
        } else {
          Get.toNamed(details);
        }
        return null;
      },
    );
  }

  Future<void> nextStep() async {
    if (currentStep < questions.length) {
      currentStep++;
      update();
    } else {
      await patientMedicalProfileSectionPost();
    }
  }

  bool get hasSelectedAnswer {
    if (questions.isEmpty) return false;
    final currentQuestion = questions[currentStep - 1];
    return currentQuestion['isSelected'] != null;
  }
}
