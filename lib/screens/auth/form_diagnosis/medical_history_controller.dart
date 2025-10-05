import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../general_exports.dart' hide FormData;

class MedicalHistoryController extends GetxController {
  int currentStep = 1;
  int get numberOfStep => questions.length;
  String? accessToken;
  String? showIsError;
  bool isLoading = false;
  bool isSendingAnswer = false;
  String? sectionName;

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
      path:
          '$pathPatientMedicalProfileSection/${stepsController.patientId}/$currentStep',
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

  Future<void> patientMedicalProfileSectionPost() async {
    final StartStepsController stepsController =
        Get.find<StartStepsController>();
    final currentQuestion = questions[currentStep - 1];

    final List<Map<String, dynamic>> selectedSubSections =
        <Map<String, dynamic>>[];
    final subSections = currentQuestion['subSection'] ?? <dynamic>[];

    final bool isSectionSelected = currentQuestion['isSelected'] == true;

    if (isSectionSelected) {
      for (final sub in subSections) {
        selectedSubSections.add(<String, dynamic>{
          'subSectionId': sub['subSectionId'] ?? 0,
          'subSectionName': sub['subSectionName'] ?? '',
          'items': sub['items'] ?? <dynamic>[],
        });
      }
    }

    final FormData formData = FormData();

    formData.fields.add(
      MapEntry(myPatientId, stepsController.patientId.toString()),
    );
    formData.fields.add(MapEntry(sectionSectionId, currentStep.toString()));
    formData.fields.add(
      MapEntry(sectionSectionName, currentQuestion['sectionName'] ?? ''),
    );

    formData.fields.add(
      MapEntry(
        'Section.SubSections',
        selectedSubSections.isNotEmpty ? jsonEncode(selectedSubSections) : '[]',
      ),
    );

    for (final MapEntry<String, String> field in formData.fields) {
      consoleLog('FormData field: ${field.key} = ${field.value}');
    }

    await ApiRequest(
      path: pathPatientMedicalProfileSection,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: formData,
    ).request(
      onSuccess: (data, response) async {
        isLoading = false;
        await sendAnswer();
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
    if (currentStep < questions.length) {
      currentStep++;
      await patientMedicalProfileSectionPost();
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
