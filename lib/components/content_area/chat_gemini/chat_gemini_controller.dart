import 'dart:convert';

import '../../../general_exports.dart';

class ChatGeminiController extends GetxController {
  bool isLoading = false;
  bool isLoadingGemini = false;
  String? accessToken;
  LocalStorage localStorage = LocalStorage();
  int? currentId;
  String? isContentType;
  String? isPatientMedicalComplaintId;
  String? message;
  String? selectedChoice;
  TextEditingController writeAnswer = TextEditingController();

  bool showWriteAnswer = false;

  @override
  void onInit() {
    _myPatientComplaint();
    super.onInit();
  }

  // ignore: always_specify_types
  List gemini = <dynamic>[];
  Future<void> _myPatientComplaint() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    await ApiRequest(
      path: patientComplaint,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        gemini = response ?? <dynamic>[];

        // ignore: always_specify_types
        for (final item in gemini) {
          switch (item['status']) {
            case 'continue':
              break;
            case 'restricted':
              break;
            case 'completed':
              break;
          }
        }
        // ignore: always_specify_types
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final LoginController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }

  // ignore: always_specify_types
  List myBodyValue = [];
  Future<void> gemeiniStart(int id) async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    await ApiRequest(
      path: '$patientComplaintStart/$id',
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
      body: jsonEncode('String'),
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        // ignore: always_specify_types
        final patientMedicalComplaintId = response['patientMedicalComplaintId'];
        // ignore: always_specify_types
        final body = response['bodyValue'];
        // ignore: always_specify_types
        final contentType = response['bodyValue']['contentType'];

        isContentType = contentType;
        isPatientMedicalComplaintId = patientMedicalComplaintId;

        myBodyValue = <dynamic>[body];

        isLoading = false;
        // ignore: always_specify_types
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final LoginController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }

  Future<void> isGemeini() async {
    isLoadingGemini = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    String? isBodyRequest;

    if (isContentType == 'McqQuestion') {
      isBodyRequest = jsonEncode(selectedChoice);
    } else if (isContentType == 'question') {
      isBodyRequest = writeAnswer.text;
    }

    await ApiRequest(
      path: '$patientComplaint/$isPatientMedicalComplaintId',
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
      body: isBodyRequest,
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        // ignore: always_specify_types
        final body = response['bodyValue'];

        if (body != null) {
          myBodyValue = <dynamic>[body];
        }

        isLoadingGemini = false;
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoadingGemini = false;
        update();
        if (statusCode == 401) {
          final LoginController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }
}
