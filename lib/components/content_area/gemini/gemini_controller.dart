import '../../../general_exports.dart';

class GeminiController extends GetxController {
  final TextEditingController writeYourOffer = TextEditingController();
  bool showwriteYourOfferError = false;
  bool isInputNotEmpty = false;

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

  @override
  void onClose() {
    writeYourOffer.dispose();
    super.onClose();
  }
}
