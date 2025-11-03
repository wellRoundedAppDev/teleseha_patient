import '../../../general_exports.dart';

class ChatGeminiController extends GetxController {
  bool isLoading = false;
  String? accessToken;
  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    _myPatientComplaint();
    super.onInit();
  }

  final List<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    <String, dynamic>{
      'text': 'Hello doctor, I feel dizzy recently.',
      'isMe': true,
    },
    <String, dynamic>{
      'text': 'Please describe your symptoms more clearly.',
      'isMe': false,
    },
    <String, dynamic>{
      'text': 'I often feel tired and have low energy.',
      'isMe': true,
    },
    <String, dynamic>{
      'text': 'It could be anemia. I recommend a blood test.',
      'isMe': false,
    },
  ];

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
        // ignore: always_specify_types
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final FingerPrintController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }
}
