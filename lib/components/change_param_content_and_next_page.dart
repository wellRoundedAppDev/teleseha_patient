import '../general_exports.dart';

class ChangeParamContentAndNextPage extends GetxController {
  RxString goToComponentHeader = 'HomePage'.obs;
  RxString knowNextPage = ''.obs;
  Rx<Widget?> overlayPage = Rx<Widget?>(null);
}
