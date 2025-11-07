import 'dart:convert';

import '../../../general_exports.dart';

class GeminiController extends GetxController {
  final TextEditingController writeYourOffer = TextEditingController();
  bool showwriteYourOfferError = false;
  bool isInputNotEmpty = false;
  bool isLoading = false;
  String? accessToken;

  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    writeYourOffer.addListener(_checkInput);
  }

  void _checkInput() {
    final bool isNotEmpty = writeYourOffer.text.trim().isNotEmpty;
    if (isInputNotEmpty != isNotEmpty) {
      isInputNotEmpty = isNotEmpty;
      update();
    }
  }

  Future<void> gemeiniChat() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    await ApiRequest(
      path: receiption,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: jsonEncode(writeYourOffer.text),
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        Get.snackbar(
          'نجاح',
          'تم تنفيذ العملية بنجاح ✅',
          snackPosition: SnackPosition.BOTTOM,
          // ignore: deprecated_member_use
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        Get.snackbar(
          'خطأ',
          'حدث خطأ أثناء تنفيذ العملية ⚠️',
          snackPosition: SnackPosition.BOTTOM,
          // ignore: deprecated_member_use
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        update();
        if (statusCode == 401) {
          final LoginController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }

  @override
  void onClose() {
    writeYourOffer.dispose();
    super.onClose();
  }
}
