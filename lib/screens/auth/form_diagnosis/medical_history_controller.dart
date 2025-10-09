import 'dart:convert';

import '../../../general_exports.dart' hide FormData;

class MedicalHistoryController extends GetxController {
  int currentStep = 1;
  int get numberOfStep => questions.length;
  String? accessToken;
  String? showIsError;
  bool isLoading = false;
  bool isSendingAnswer = false;
  String? sectionName;
  int? loukMyPatientId;

  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadPatientId();
    medicalProfileSection();
  }

  Future<void> loadPatientId() async {
    final String? userJson = await localStorage.readFromStorage(
      storageUserData,
    );
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final int? patientId = userMap['patients']?[0]?['patientId'];
      if (patientId != null) {
        loukMyPatientId = patientId;
      }
    }
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
        if (questions.isNotEmpty) {
          sectionName = questions.first['sectionName'];
        }
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

  Future<void> sendAnswer() async {
    isSendingAnswer = true;
    update();

    final StartStepsController stepsController =
        Get.find<StartStepsController>();

    accessToken = await localStorage.readFromStorage(storageAccessToken);

    await ApiRequest(
      path: '$pathPatientMedicalProfileSection/$loukMyPatientId/$currentStep',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    ).request(
      // ignore: always_specify_types
      onSuccess: (data, response) {
        currentStep = response['sectionId'];
        sectionName = response['sectionName'];
      },
      onError: (error) {
        return null;
      },
    );
    isSendingAnswer = false;
    update();
  }

  Future<void> patientMedicalProfileSectionPost(
    Map<String, dynamic> currentQuestion,
  ) async {
    final currentQuestion = questions[currentStep - 1];
    final subSections = currentQuestion['subSection'] ?? <dynamic>[];
    final List<Map<String, dynamic>> selectedSubSections =
        <Map<String, dynamic>>[];

    for (final sub in subSections) {
      final items = sub['items'] ?? <dynamic>[];

      final selectedItems = items
          .where((item) => item['isSelected'] == true)
          .map((item) {
            return <String, dynamic>{
              itemId: item['itemId'],
              itemName: item['itemName'],
              subSectionId: item['subSectionId'],
            };
          })
          .toList();

      if (selectedItems.isNotEmpty) {
        final Map<String, dynamic> subSectionData = <String, dynamic>{
          'subSectionId': sub['subSectionId'],
          'subSectionName': sub['subSectionName'],
          'sectionId': sub['sectionId'],
          'items': selectedItems,
        };

        selectedSubSections.add(subSectionData);
      }
    }

    final Map<String, Object?> bodyData = <String, Object?>{
      myPatientId: loukMyPatientId,
      section: <String?, dynamic>{
        sectionId: currentStep,
        logukSectionName: currentQuestion['sectionName'] ?? '',
        sectionSubSection: selectedSubSections,
      },
    };

    await ApiRequest(
      path: pathPatientMedicalProfileSection,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
      body: bodyData,
    ).request(
      onSuccess: (data, response) async {
        isLoading = false;
        // await sendAnswer();
        update();
      },
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
    if (isLoading) return;

    if (currentStep < questions.length) {
      await patientMedicalProfileSectionPost(questions[currentStep - 1]);
      ++currentStep;
      update();
    } else {
      Get.toNamed(details);
    }
  }

  bool get hasSelectedAnswer {
    if (questions.isEmpty) return false;
    final currentQuestion = questions[currentStep - 1];
    return currentQuestion['isSelected'] != null;
  }
}
